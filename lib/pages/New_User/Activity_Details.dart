// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Page Imports
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/Models/Custom_Models/Activity_Option.dart';
import 'package:Client/Helper_Widgets/ButtonProducer.dart';
import 'package:Client/Helper_Widgets/GeneralNetworkingMethodManager.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/pages/Home.dart';

// Template to make Activity Details Page
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

  // Array to hold the resources
  final resources = [
    "Bicycle",
    "Assault Bike",
    "Trap Bar",
    "Barbells",
    "Plates",
    "Bands",
    "Suspension Trainers",
    "Skipping Rope",
    "Treadmill",
    "Slam Ball",
    "Kettle Bells"
  ];

  // Array to hold the outdoor activities
  final activities = [
    "Swim",
    "Run",
    "Walk",
    "At Home Workout",
    "Gym",
    "Skip",
    "Hike",
    "Cycle"
  ];

  // Variables to distinguish the different activity preferences
  final activityOptions = [
    new Activity_Option("Home\n Workout", "Home_Workout",
        "Resources/Images/Home_Workout.svg", false),
    new Activity_Option("Gym \nWorkout", "Gym_Workout",
        "Resources/Images/GymWeights.svg", false),
    new Activity_Option("Outdoor\n Activity", "Outdoor_Activity",
        "Resources/Images/Outdoor_Act.svg", false)
  ];
  double _defaultIntensity = 20.0;
  double _defaultActivityLevel = 20.0;

  double _pageHeight = 1000;

  // Info  pop up to be used to alert user to a error within their input
  InformationPopUp infoPopUp = new InformationPopUp();

  // Checking which activity is chosen and rendering based on this
  Widget checkWhichActivityChosen(String activityChosen) {
    switch (activityChosen) {
      case "Home_Workout":
        setState(() {
          _pageHeight = 1150;
        });
        return getActivityDetailsResources();
      case "Gym_Workout":
        setState(() {
          _pageHeight = 800;
        });
        return Container(
          height: 10,
        );
      case "Outdoor_Activity":
        setState(() {
          _pageHeight = 1150;
        });
        return getActivityDetailsOutdoorActivities();
    }
    // setState(() {
    //   _pageHeight = _pageHeight;
    // });
    return Container();
  }

  // Retrieves the word labels for the sliders based on input given
  String getLabel(double percLevel, String mode) {
    var modes = {
      "Fitness": {
        0: "Inactive",
        20: "Slightly Active",
        40: "Moderately Active",
        60: "Active",
        80: "Very Active",
        100: "Super Active"
      },
      "Intensity": {
        0: "Not Intensive",
        20: "Slightly Intensive",
        40: "Moderately Intensive",
        60: "Intensive",
        80: "Very Intensive",
        100: "Super Intensive"
      }
    };
    return modes[mode][percLevel];
  }

  _setUpUser(BuildContext context) async {
    try {
      // // Result from logging in user could either be a error or user
      dynamic createdUser = await GeneralNetworkingMethodManager(context)
          .getUserController()
          .createUser(widget.user);

      // Checking if the result is a error
      if (createdUser.runtimeType == InformationPopUp) {
        if (createdUser.message != null) {
          // Displaying error in pop up by setting the state
          setState(() {
            infoPopUp = createdUser;
          });
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (createdUser.username != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(user: createdUser),
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
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: activityDetailsBody(),
    );
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

  // Building the Activity Details Page Body
  Widget activityDetailsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: _pageHeight,
            child: Column(
              children: [
                if (infoPopUp.message != null) checkForLoginErrorPopUp(),
                activityDetailsPageSliders(context),
                preferredActivityType(),
                if (widget.user.preferredActivity != null)
                  checkWhichActivityChosen(widget.user.preferredActivity),
                Container(
                  height: 50,
                ),
                createContinueToBasicDetailsPageBtn(context),
              ],
            ),
          )
        ],
      ),
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

  // Building Activity Details Sliders
  Widget activityDetailsPageSliders(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 195,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Pick your fitness Level",
              style: GoogleFonts.meriendaOne(
                color: HexColor("#000000"),
                fontSize: 15,
              ),
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              rangeTickMarkShape: RoundRangeSliderTickMarkShape(
                tickMarkRadius: 500,
              ),
            ),
            child: Slider(
              min: 0.0,
              max: 100.0,
              divisions: 5,
              activeColor: HexColor("#EB9661"),
              // inactiveColor: HexColor("#2E2B2B"),
              label: getLabel(_defaultActivityLevel, "Fitness"),
              value: _defaultActivityLevel,
              onChanged: (val) => {
                widget.user.fitnessLevel =
                    getLabel(_defaultActivityLevel, "Fitness"),
                setState(() {
                  _defaultActivityLevel = val;
                })
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Pick your activity intensity level",
              style: GoogleFonts.meriendaOne(
                color: HexColor("#000000"),
                fontSize: 15,
              ),
            ),
          ),
          SliderTheme(
            data: SliderThemeData(),
            child: Slider(
              min: 0.0,
              max: 100.0,
              divisions: 5,
              activeColor: HexColor("#EB9661"),
              label: getLabel(_defaultIntensity, "Intensity"),
              value: _defaultIntensity,
              onChanged: (val) => {
                widget.user.preferredIntensity =
                    getLabel(_defaultIntensity, "Intensity"),
                setState(
                  () {
                    _defaultIntensity = val;
                  },
                )
              },
            ),
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
                children: resources.map((resource) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#C8C8C8'))),
                    child: FlatButton(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              resource,
                              style: TextStyle(fontSize: 11.0),
                            )
                          ]),
                      color: widget.user.resources.contains(resource)
                          ? HexColor('#EB9661')
                          : Colors.transparent,
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
                children: activities.map((activity) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#C8C8C8'))),
                    child: FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            activity,
                            style: TextStyle(fontSize: 11.0),
                          )
                        ],
                      ),
                      color: widget.user.activitiesEnjoyed.contains(activity)
                          ? HexColor('#EB9661')
                          : Colors.transparent,
                      onPressed: () => {
                        if (!widget.user.activitiesEnjoyed.contains(activity))
                          {widget.user.activitiesEnjoyed.add(activity)}
                        else
                          {widget.user.activitiesEnjoyed.remove(activity)},
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

  // Creates the Activity type Container
  Widget preferredActivityType() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: activityOptions.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                activityOptions.forEach((gender) => gender.isSelected = false);
                activityOptions[index].isSelected = true;
                widget.user.preferredActivity =
                    activityOptions[index].hiddenText;
              });
            },
            child: ActivityOptionRadio(activityOptions[index]),
          );
        },
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
