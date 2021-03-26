// Imports

// Library Imports
import 'package:Client/Config/configVariables.dart';
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Profile_Page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Config/configVariables.dart' as Constants;
import 'package:Client/Presentation/Activity_Management/Read_Activity_Management/Read_Activities_Match_View.dart';

// Template to make the Buds View Page
class BudsView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /*
      Setting up variables for this page
    */

    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            // Widget to make the appBar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:
                                      Constants.StyleVariableStore.shadowList,
                                ),
                                // margin: EdgeInsets.only(top: 10),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    "Resources/Images/Gymbud_Logo.svg",
                                    height: 60,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: logged_in_user?.profileUrl != null
                        ? new NetworkImage(logged_in_user.profileUrl)
                        : null,
                    // backgroundColor: Colors.orange,
                  ),
                ],
              ),
            ),

            // Widget to make the search bar row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search for a bud here...'),
                  Icon(Icons.settings),
                ],
              ),
            ),

            // Widget to make the horizontal scroll view

            // Widget to make the horizontal scroll view
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 5, left: 20),
                  child: Text(
                    "Signed Up Activities".toUpperCase(),
                    style: GoogleFonts.delius(
                      color: HexColor("EB9661"),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GeneralVariableStore.fakeActivities.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow:
                                    Constants.StyleVariableStore.shadowList,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'Resources/Images/${GeneralHelperMethodManager.getActivitySVG(GeneralVariableStore.fakeActivities[index].activityType)}.svg',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                height: 20,
                                width: 25,
                                decoration: BoxDecoration(
                                  color:
                                      GeneralHelperMethodManager.checkDaysUntil(
                                          GeneralVariableStore
                                              .fakeActivities[index].date),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  GeneralVariableStore
                                              .fakeActivities[index].date !=
                                          null
                                      ? "${GeneralVariableStore.fakeActivities[index].date}d"
                                      : "2d",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "With \n ${GeneralVariableStore.fakeActivities[index].creator.username}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.delius(
                              color: HexColor("2E2B2B"),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Widget to make the rows for the conversations
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Buds".toUpperCase(),
                    style: GoogleFonts.delius(
                      color: HexColor("EB9661"),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Expanded(
                    child: Container(
                      height: 180,
                      width: 380,
                      // color: HexColor("EB9661"),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Find Some Buds",
                              style: GoogleFonts.delius(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            style: StyleVariableStore.sign_up_button_style,
                            onPressed: () async {
                              List<Activity> all_activities = await context
                                  .read(activities_provider)
                                  .readActivities();
                              context
                                  .read(activities_notifier_provider)
                                  .addActivities(all_activities);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MatchView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
