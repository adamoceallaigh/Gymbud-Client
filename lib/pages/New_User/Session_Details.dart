import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

import '../home.dart';

class SessionDetails extends StatefulWidget {
  final User user;

  SessionDetails({Key key, @required this.user}) : super(key: key);
  @override
  _SessionDetailsState createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
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
  final sessionOptions = ["At Home", "Gym"];
  final _selectionOptions = List.generate(2, (_) => false);
  double _defaultIntensity = 20.0;
  double _defaultActivityLevel = 20.0;
  // var pressed = false ; // This is the press variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: sessionBody());
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Image.asset("Resources/Images/logoGymbud.png",
          height: 100.0, width: 100.0),
      backgroundColor: HexColor("FEFEFE"),
    );
  }

  String getGirlPhoto() {
    var girlUrls = [
      "https://firebasestorage.googleapis.com/v0/b/gymbud-58be5.appspot.com/o/Stephanie.jpg?alt=media&token=6f2bdcf1-f45e-4a08-96f3-6e7acf07ffc6",
      "https://firebasestorage.googleapis.com/v0/b/gymbud-58be5.appspot.com/o/Britanny.jpg?alt=media&token=ec32091b-0229-4d0b-b0ec-cde359e781c0"
    ];
    return girlUrls[new Random().nextInt(1)];
  }

  void _setUpUser() async {
    UserController userController = new UserController();
    widget.user.gender == "male"
        ? widget.user.profileUrl =
            "https://firebasestorage.googleapis.com/v0/b/gymbud-58be5.appspot.com/o/James.jpg?alt=media&token=123f37e9-e7a8-4823-b6a6-ee86e4cc7e59"
        : widget.user.profileUrl = getGirlPhoto();
    print(widget.user.toString());
    User newUser = await userController.createUser(widget.user);
    if (newUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(user: widget.user)),
      );
    }
  }

  Widget sessionBody() {
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
                  child: Text("Pick your session intensity level"),
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
                  child: Text("Pick your preferred session method"),
                ),
                ToggleButtons(
                  children: [
                    SvgPicture.asset(
                      "Resources/Images/Home_Workout.svg",
                      height: 100,
                      semanticsLabel: 'At Home',
                      width: 150,
                    ),
                    SvgPicture.asset(
                      "Resources/Images/gym.svg",
                      height: 100,
                      semanticsLabel: 'Gym',
                      width: 150,
                    ),
                  ],
                  isSelected: _selectionOptions,
                  onPressed: (int index) => {
                    widget.user.videoOrInPerson = getSessionOption(index),
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
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton(
                    child: Text("Finish"),
                    onPressed: () => {
                      // print(widget.user.toString()),
                      _setUpUser()
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

  String getSessionOption(int index) {
    return sessionOptions[index];
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

// body: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(40.0),
//               child: Text(
//                 "Pick the resources you have",
//               ),
//             ),
//             GridView(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3
//               ),
//               children: resources.map((resource) {
//                 return GestureDetector(
//                   child: Card(
//                     margin: EdgeInsets.all(20.0),
//                     child: ResourceOption()
//                   ),
//                   onTap: () => {
//                     if (!widget.user.resources.contains(resource)){
//                       widget.user.resources.add(resource)
//                     } else {
//                       widget.user.resources.remove(resource)
//                     },
//                     setState(() => {})
//                   },
//                 );
//               }).toList(),
//               //   return Container(
//               //         decoration: BoxDecoration(
//               //             border: Border.all(color: HexColor('#C8C8C8'))
//               //         ),
//               //         child: FlatButton(
//               //           child: Column(
//               //               mainAxisAlignment: MainAxisAlignment.center,
//               //               children: [Text(resource)]
//               //           ),
//               //           color: widget.user.resources.contains(resource)
//               //               ? HexColor('#EB9661')
//               //               : Colors.transparent,
//               //           onPressed: () => {
//               //               if (!widget.user.resources.contains(resource)){
//               //                 widget.user.resources.add(resource)
//               //               } else {
//               //                 widget.user.resources.remove(resource)
//               //               },
//               //             setState(() => {})
//               //           },
//               //         ),
//               //       );
//               // }).toList(),
//               // shrinkWrap: true,
//             ),
//     return Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: HexColor('#C8C8C8'))
//           ),
//           child: FlatButton(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [Text(resources[resource])]),
//             color: widget.user.resources
//                     .contains(resources[resource])
//                 ? HexColor('#EB9661')
//                 : Colors.transparent,
//             onPressed: () => {
//               if (!widget.user.resources
//                   .contains(resources[resource]))
//                 {
//                   widget.user.resources
//                       .add(resources[resource])
//                 }
//               else
//                 {
//                   widget.user.resources
//                       .remove(resources[resource])
//                 },
//               setState(() => {})
//             },
//           ),
//         );
//   }),
// ),
//             // children: List.generate(
//             //     resources.length,
//             //     (resource) => Container(
//             //           decoration: BoxDecoration(
//             //               border: Border.all(color: HexColor('#C8C8C8'))
//             //           ),
//             //           child: FlatButton(
//             //             child: Column(
//             //                 mainAxisAlignment: MainAxisAlignment.center,
//             //                 children: [Text(resources[resource])]),
//             //             color: widget.user.resources
//             //                     .contains(resources[resource])
//             //                 ? HexColor('#EB9661')
//             //                 : Colors.transparent,
//             //             onPressed: () => {
//             //               if (!widget.user.resources
//             //                   .contains(resources[resource]))
//             //                 {
//             //                   widget.user.resources
//             //                       .add(resources[resource])
//             //                 }
//             //               else
//             //                 {
//             //                   widget.user.resources
//             //                       .remove(resources[resource])
//             //                 },
//             //               setState(() => {})
//             //             },
//             //           ),
//             //         ))
//             // ),
//             Container(
//               padding: EdgeInsets.all(40.0),
//               child: Text(
//                 "Pick the activities you enjoy",
//               ),
//             ),
//             // GridView.count(
//             //         crossAxisCount: 3,
//             //         scrollDirection: Axis.vertical,
//             //         primary: false,
//             //         children: List.generate(
//             //             activities.length,
//             //             (activity) => Container(
//             //               decoration: BoxDecoration(
//             //                       border: Border.all(color: HexColor('#C8C8C8'))
//             //                   ),
//             //               child: FlatButton(
//             //                     child: Column(
//             //                         mainAxisAlignment: MainAxisAlignment.center,
//             //                         children: [Text(activities[activity])]),
//             //                     color: widget.user.activitiesEnjoyed.contains(activities[activity])
//             //                         ? HexColor('#EB9661')
//             //                         : Colors.transparent,
//             //                     onPressed: () => {
//             //                       if (!widget.user.activitiesEnjoyed.contains(activities[activity])){
//             //                           widget.user.activitiesEnjoyed.add(activities[activity])
//             //                         }else{
//             //                           widget.user.activitiesEnjoyed.remove(activities[activity])
//             //                         },
//             //                       setState(() => {})
//             //                     },
//             //                   ),
//             //             )))
