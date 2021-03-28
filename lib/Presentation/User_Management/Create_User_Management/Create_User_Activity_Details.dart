// Copyrighted by Adam O' Ceallaigh Sun 28 Mar 2021

// Imports

// Library Imports
import 'package:Client/Helpers/GeneralComponents.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/General_Pages/Home_Screen.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Config/configVariables.dart' as Constants;

class ActivityDetails extends HookWidget {
  /*
    Setting the variable for this page
  */

  // User object to be required to transfer values across pages
  User user;
  ActivityDetails({Key key, @required this.user}) : super(key: key);
  /*
    Setting the variable for this page
  */

  _setUpUser(BuildContext context) async {
    try {
      user.fitnessLevel =
          context.read(user_notifier_provider.state).fitnessLevel;
      user.preferredIntensity =
          context.read(user_notifier_provider.state).preferredIntensity;
      // Result from logging in user could either be a error or user
      dynamic createdUser = await context.read(user_provider).createUser(user);

      // Checking if the result is a error
      if (createdUser.runtimeType == InformationPopUp) {
        if (createdUser.message != null) {
          // Displaying error in pop up by setting the state
          // setState(() {
          //   infoPopUp = createdUser;
          // });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (route) => false,
          );
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (createdUser.username != null) {
          context.read(user_notifier_provider).createUser(createdUser);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
          user = new User();
        } else {
          // infoPopUp.message =
          //     "An error occurred while registering. Please try again";
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    final user_notifier = useProvider(user_notifier_provider.state);

    // Building the app bar
    AppBar buildAppBar() {
      return AppBar(
        leadingWidth: 100,
        leading: Container(
          child: Image.asset(
            'Resources/Images/logoGymbud.png',
          ),
        ),
        backgroundColor: HexColor("FEFEFE"),
      );
    }

    // Checking for Errors Pop Up
    Widget checkForLoginErrorPopUp() {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            // Expanded(child: Text(infoPopUp.message)),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => {
                // setState(() {
                //   infoPopUp.message = null;
                // })
              },
            ),
          ],
        ),
      );
    }

    // Building the Activity Details Resources
    Widget getActivityDetailsResources() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Pick the resources you have",
                style: GoogleFonts.meriendaOne(
                  color: HexColor("#000000"),
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  crossAxisCount: 4,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  shrinkWrap: true,
                  children:
                      Constants.ActivityVariableStore.resources.map((resource) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#C8C8C8'))),
                      child: TextButton(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(resource,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: user.resources.contains(resource)
                                        ? HexColor('#EB9661')
                                        : Colors.transparent,
                                  ))
                            ]),
                        onPressed: () => {
                          if (!user.resources.contains(resource))
                            {user.resources.add(resource)}
                          else
                            {user.resources.remove(resource)},
                          // setState(() => {})
                        },
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
      );
    }

    // Building the activity details outdoor activities
    Widget getActivityDetailsOutdoorActivities() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pick the activities you enjoy",
                style: GoogleFonts.meriendaOne(
                  color: HexColor("#000000"),
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  crossAxisCount: 4,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  shrinkWrap: true,
                  children: Constants.ActivityVariableStore.activities
                      ?.map((activity) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#C8C8C8'))),
                      child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              activity,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: user.activitiesEnjoyed.contains(activity)
                                    ? HexColor('#EB9661')
                                    : Colors.transparent,
                              ),
                            )
                          ],
                        ),
                        onPressed: () => {
                          if (!user.activitiesEnjoyed.contains(activity))
                            {user.activitiesEnjoyed.add(activity)}
                          else
                            {user.activitiesEnjoyed.remove(activity)},
                          // setState(() => {})
                        },
                      ),
                    );
                  })?.toList()),
            ),
          ],
        ),
      );
    }

    // Create the button to navigate to the basic details page
    Widget createContinueToBasicDetailsPageBtn(BuildContext context) {
      return Container(
        child: ElevatedButton(
          style: ButtonProducer.getOrangeGymbudBtn(),
          onPressed: () {
            _setUpUser(context);
          },
          child: Text(
            "Finish",
            style: GoogleFonts.delius(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Constants.GeneralVariableStore.pageHeight,
                child: Column(
                  children: [
                    // if (infoPopUp.message != null) checkForLoginErrorPopUp(),
                    ActivitySliders(context: context, place: "User"),
                    SelectFromOptionsWidget(
                      generalOptions:
                          Constants.ActivityVariableStore.mainActivityOptions,
                      placeToChangeFrom: "User",
                      whatToChange: "Type",
                    ),
                    if (user_notifier.preferredActivity == "Home_Workout")
                      ActivityResourcesGrid(context: context, place: "User"),
                    Container(
                      height: 50,
                    ),
                    createContinueToBasicDetailsPageBtn(context),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
