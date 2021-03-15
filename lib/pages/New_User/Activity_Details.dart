// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

// Page Imports
import 'package:Client/Controllers/UserController.dart';
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
  final activityOptions = ["At Home", "Gym", "Outdoor Activity"];
  final _selectionOptions = List.generate(3, (_) => false);
  double _defaultIntensity = 20.0;
  double _defaultActivityLevel = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: activityDetailsBody());
  }

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

  Widget activityDetailsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 1100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Pick your fitness Level"),
                ),
                SliderTheme(
                  data: SliderThemeData(),
                  child: Slider(
                      min: 0.0,
                      max: 100.0,
                      divisions: 5,
                      activeColor: HexColor("#EB9661"),
                      label: getLabel(_defaultActivityLevel, "Fitness"),
                      value: _defaultActivityLevel,
                      onChanged: (val) => {
                            widget.user.fitnessLevel =
                                getLabel(_defaultActivityLevel, "Fitness"),
                            setState(() {
                              _defaultActivityLevel = val;
                            })
                          }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Pick your activity intensity level"),
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
                            setState(() {
                              _defaultIntensity = val;
                            })
                          }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Pick the resources you have"),
                ),
                SizedBox(
                  height: 200,
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
                Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Text("Pick the activities you enjoy"),
                ),
                SizedBox(
                  height: 200,
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
                            color:
                                widget.user.activitiesEnjoyed.contains(activity)
                                    ? HexColor('#EB9661')
                                    : Colors.transparent,
                            onPressed: () => {
                              if (!widget.user.activitiesEnjoyed
                                  .contains(activity))
                                {widget.user.activitiesEnjoyed.add(activity)}
                              else
                                {
                                  widget.user.activitiesEnjoyed.remove(activity)
                                },
                              setState(() => {})
                            },
                          ),
                        );
                      }).toList()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text("Pick your preferred activity"),
                ),
                ToggleButtons(
                  children: [
                    SvgPicture.asset(
                      "Resources/Images/Home_Workout.svg",
                      height: 100,
                      semanticsLabel: 'Outdoor Activity',
                      width: 150,
                    ),
                    SvgPicture.asset(
                      "Resources/Images/gym.svg",
                      height: 100,
                      semanticsLabel: 'Gym',
                      width: 150,
                    ),
                    SvgPicture.asset(
                      "Resources/Images/gym.svg",
                      height: 100,
                      semanticsLabel: 'Home Workout',
                      width: 150,
                    ),
                  ],
                  isSelected: _selectionOptions,
                  onPressed: (int index) => {
                    widget.user.videoOrInPerson = getActivityOption(index),
                    setState(() {
                      for (int indexBtn = 0;
                          indexBtn < _selectionOptions.length;
                          indexBtn++) {
                        if (indexBtn == index) {
                          _selectionOptions[indexBtn] =
                              !_selectionOptions[indexBtn];
                        } else {
                          _selectionOptions[indexBtn] = false;
                        }
                      }
                    })
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("At Home"),
                      SizedBox(width: 50),
                      Text("Gym")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton(
                    child: Text("Finish"),
                    onPressed: () => {
                      // print(widget.user.toString()),
                      // _setUpUser(context)
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getActivityOption(int index) {
    return activityOptions[index];
  }

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
}
