import 'package:Client/Helper_Widgets/GeneralHelperMethodManager.dart';
import 'package:Client/Helper_Widgets/GeneralNetworkingMethodManager.dart';
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Models/Activity.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/SingleActivityView.dart';
import 'package:flutter/material.dart';
import 'package:Client/Controllers/ActivityController.dart';
//Importing TinderSwipeCard here allowing me to have same functionality easily as tinder cards
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchView extends StatefulWidget {
  final User user;

  MatchView({this.user});

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  List<Activity> activities = [];

  //Declaring my tinderCardController to be able to indicate when we swipe left or right easily
  CardController tinderCardController;

  void setupActivities() async {
    GeneralNetworkingMethodManager(context)
        .getActivityController()
        .readActivities()
        .then((activity) => setState(() {
              activities.addAll(activity);
            }));
  }

  List<Widget> getAttendeeCircles(int index) {
    List<Widget> widgetList = [];
    double left = 0;
    if (activities[index].participants.length == 1)
      left = 0;
    else
      left = -18;
    for (var user in activities[index].participants) {
      left += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
          left: left,
        ),
      );
    }
    widgetList.add(Container());
    return widgetList;
  }

  @override
  void initState() {
    super.initState();
    setupActivities();
  }

  // Using TinderSwipeCard here - library from pub.dev which allows you very easily to have cards with same functionality as tinder cards
  // https://pub.dev/packages/flutter_tindercard/example

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height + 120) * 0.6,
          child: TinderSwapCard(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.height * 0.85,
            cardBuilder: (context, index) {
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleActivityView(
                        activity: activities[index],
                        user: widget.user,
                      ),
                    ),
                  ),
                },
                child: Hero(
                  tag: 'Activity ${activities[index].hashCode}',
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
                              activities[index].activityImageUrl,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Activity Description",
                                        style: GoogleFonts.meriendaOne(
                                          color: HexColor("#000000"),
                                          fontSize: 18,
                                          letterSpacing: -1.5,
                                        ),
                                      ),
                                      Text(activities[index]
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Stack(
                                          children: getAttendeeCircles(index),
                                        ),
                                      ),
                                      Text(
                                        '${activities[index].participants.length.toString()} / 6',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(
                                        activities[index].resources.toString()),
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
                                        Text(activities[index]
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
                                                    color: HexColor("#000000"),
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
                                                  backgroundImage: NetworkImage(
                                                      activities[index]
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
            cardController: tinderCardController = CardController(),
            totalNum: activities.length,
          ),
        ),
      ),
    );
  }
}
