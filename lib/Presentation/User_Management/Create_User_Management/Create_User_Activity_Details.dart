// Imports

// Library Imports
import 'package:Client/Helpers/GeneralComponents.dart';
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

class ActivityDetails extends StatefulWidget {
  /*
    Setting the variable for this page
  */

  // User object to be required to transfer values across pages
  final User user;
  ActivityDetails({Key key, @required this.user}) : super(key: key);

  @override
  _ActivityDetailsState createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  /*
    Setting the variable for this page
  */

  // Info  pop up to be used to alert user to a error within their input
  InformationPopUp infoPopUp = new InformationPopUp();

  // Checking which activity is chosen and rendering based on this
  Widget checkWhichActivityChosen(String activityChosen) {
    switch (activityChosen) {
      case "Home_Workout":
        setState(() {
          Constants.GeneralVariableStore.pageHeight = 1150;
        });
        return getActivityDetailsResources();
      case "Gym_Workout":
        setState(() {
          Constants.GeneralVariableStore.pageHeight = 800;
        });
        return Container(
          height: 10,
        );
      case "Outdoor_Activity":
        setState(() {
          Constants.GeneralVariableStore.pageHeight = 1150;
        });
        return getActivityDetailsOutdoorActivities();
    }
    setState(() {
      Constants.GeneralVariableStore.pageHeight =
          Constants.GeneralVariableStore.pageHeight;
    });
    return Container();
  }

  _setUpUser(BuildContext context) async {
    try {
      // // // Result from logging in user could either be a error or user
      dynamic createdUser =
          await context.read(user_provider).createUser(widget.user);

      // Checking if the result is a error
      if (createdUser.runtimeType == InformationPopUp) {
        if (createdUser.message != null) {
          // Displaying error in pop up by setting the state
          setState(() {
            infoPopUp = createdUser;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (createdUser.username != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          infoPopUp.message =
              "An error occurred while registering. Please try again";
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    final user_notifier = context.read(user_notifier_provider.state);

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
                    if (infoPopUp.message != null) checkForLoginErrorPopUp(),
                    ActivitySliders(context: context, place: "User"),
                    SelectFromOptionsWidget(
                      generalOptions:
                          Constants.ActivityVariableStore.mainActivityOptions,
                      placeToChangeFrom: "User",
                      whatToChange: "Type",
                    ),
                    Consumer(builder: (context, watch, _) {
                      final user_notifier_preferredActivity =
                          watch(user_notifier_provider.state);
                      if (user_notifier_preferredActivity.preferredActivity ==
                          "Home_Workout")
                        return ActivityResourcesGrid(
                            context: context, place: "User");
                      return SizedBox(
                        height: 0,
                      );
                    }),
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
          Expanded(child: Text(infoPopUp.message)),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {
              setState(() {
                infoPopUp.message = null;
              })
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
                                  color:
                                      widget.user.resources.contains(resource)
                                          ? HexColor('#EB9661')
                                          : Colors.transparent,
                                ))
                          ]),
                      onPressed: () => {
                        if (!widget.user.resources.contains(resource))
                          {widget.user.resources.add(resource)}
                        else
                          {widget.user.resources.remove(resource)},
                        setState(() => {})
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
                children:
                    Constants.ActivityVariableStore.activities?.map((activity) {
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
                              color: widget.user.activitiesEnjoyed
                                      .contains(activity)
                                  ? HexColor('#EB9661')
                                  : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                      onPressed: () => {
                        if (!widget.user.activitiesEnjoyed.contains(activity))
                          {widget.user.activitiesEnjoyed.add(activity)}
                        else
                          {widget.user.activitiesEnjoyed.remove(activity)},
                        setState(() => {})
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
      width: 300,
      height: 60,
      child: ElevatedButton(
        style: ButtonProducer.getOrangeGymbudBtn(),
        onPressed: () {
          _setUpUser(context);
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Finish",
            style: GoogleFonts.concertOne(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
