// Imports

// Library Imports
import 'package:Client/Config/configVariables.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/Activity_Management/Read_Activity_Management/Read_Single_Activity_View.dart';
import 'package:Client/Presentation/General_Pages/Filter_Activity.dart';
import 'package:flutter/material.dart';
//Importing TinderSwipeCard here allowing me to have same functionality easily as tinder cards
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';

class MatchView extends HookWidget {
  //Declaring my tinderCardController to be able to indicate when we swipe left or right easily
  final CardController tinderCardController = new CardController();

  // Using TinderSwipeCard here - library from pub.dev which allows you very easily to have cards with same functionality as tinder cards
  // https://pub.dev/packages/flutter_tindercard/example

  @override
  Widget build(BuildContext context) {
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager = GeneralHelperMethodManager(
        logged_in_user: logged_in_user, context: context);

    // Obtaining all all_activities
    final all_activities = useProvider(activities_notifier_provider.state);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            height: (MediaQuery.of(context).size.height + 120) * 0.6,
            child: TinderSwapCard(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.height * 0.85,
              cardBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    context
                        .read(activity_notifier_provider)
                        .createActivity(all_activities[index]),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleActivityView(),
                      ),
                    ),
                  },
                  child: Hero(
                    tag: 'Activity ${all_activities[index].hashCode}',
                    child: Card(
                      margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Container(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                all_activities[index].activityImageUrl,
                                alignment: Alignment.lerp(
                                    Alignment.center, Alignment.topCenter, .3),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            height: 80,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Activity Description",
                                          style: GoogleFonts.meriendaOne(
                                            color: HexColor("#000000"),
                                            fontSize: 18,
                                            letterSpacing: -1.5,
                                          ),
                                        ),
                                        Text(all_activities[index]
                                            .activityDescription),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 2),
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Stack(
                                            children: generalHelperMethodManager
                                                .getAttendeeCirclesMatchView(
                                                    index, all_activities),
                                          ),
                                        ),
                                        Text(
                                          '${all_activities[index].participants.length.toString()} / 6',
                                          style: GoogleFonts.meriendaOne(
                                            color: HexColor("#000000"),
                                            fontSize: 18,
                                            letterSpacing: -1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            height: 50,
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Resources",
                                        style: GoogleFonts.meriendaOne(
                                          color: HexColor("#000000"),
                                          fontSize: 18,
                                          letterSpacing: -1.5,
                                        ),
                                        // style: TextStyle(
                                        //   fontWeight: FontWeight.w500,
                                        //   fontSize: 16,
                                        // ),
                                      ),
                                      Row(
                                        children: all_activities[index]
                                            .resources
                                            .map((resource) => Text(resource))
                                            .toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            height: 60,
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Intensity",
                                            style: GoogleFonts.meriendaOne(
                                              color: HexColor("#000000"),
                                              fontSize: 18,
                                              letterSpacing: -1.5,
                                            ),
                                            // style: TextStyle(
                                            //   fontWeight: FontWeight.w500,
                                            //   fontSize: 16,
                                            // ),
                                          ),
                                          Text(all_activities[index]
                                              .activityIntensityLevel),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 80,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Text(
                                                    "by",
                                                    style:
                                                        GoogleFonts.meriendaOne(
                                                      color:
                                                          HexColor("#000000"),
                                                      fontSize: 18,
                                                      letterSpacing: -1.5,
                                                    ),
                                                  ),
                                                  left: 5,
                                                  top: 0,
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  left: 25,
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            all_activities[
                                                                    index]
                                                                .creator
                                                                .profileUrl),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              cardController: tinderCardController,
              totalNum: all_activities.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonProducer.getFollowGymbudBtn(),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilterActivity()))
                },
                child: Text("Filter"),
              )
            ],
          )
        ],
      ),
    );
  }
}
