import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/Session.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

class AddSession extends StatefulWidget {
  final User user;
  final Session session;
  AddSession({Key key, this.user, this.session}) : super(key: key);

  @override
  _AddSessionState createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final _formKey = GlobalKey<FormBuilderState>();
  final genderOptions = ["Male", "Female", "No Preference"];
  double _defaultIntensity = 20.0;
  double _defaultActivityLevel = 20.0;
  double _defaultBudgetLevel = 10.0;

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

  String getActivitySVG(String type) {
    var activityTypes = {
      "Home Workout": "Home_Workout",
      "Gym Workout": "GymWeights",
      "Outdoor Activity": "Outdoor_Act"
    };
    return activityTypes[type];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 1320,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 180,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              height: 90,
                              width: 93,
                              child: SvgPicture.asset(
                                'Resources/Images/Gymbud_Logo.svg',
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 10,
                            child: Container(
                              height: 70,
                              width: 73,
                              child: SvgPicture.asset(
                                "Resources/Images/${getActivitySVG(widget.session.activityType)}.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormBuilder(
                  key: _formKey,
                  child: Container(
                    height: 1070,
                    margin: EdgeInsets.all(10),
                    width: double.infinity - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type Of Activity"),
                        Text(widget.session.activityType),
                        Text("Name Of Workout"),
                        FormBuilderTextField(
                          name: 'Workout_Name',
                        ),
                        Text("Description Of Workout"),
                        FormBuilderTextField(
                          name: 'Workout_Description',
                        ),
                        Text("Looking to Workout With"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                SvgPicture.asset("Resources/Images/Male.svg"),
                                Text("Male")
                              ],
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                SvgPicture.asset("Resources/Images/Female.svg"),
                                Text("Female")
                              ],
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                SvgPicture.asset(
                                    "Resources/Images/All_Gender.svg"),
                                Text("No Preference")
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              child: FormBuilderRadioGroup(
                                name: 'Gender_Preference',
                                options: genderOptions
                                    .map(
                                      (lang) => FormBuilderFieldOption(
                                        value: lang,
                                        child: Text(''),
                                      ),
                                    )
                                    .toList(growable: false),
                              ),
                            ),
                          ],
                        ),
                        Text("Date Time Picker"),
                        FormBuilderDateTimePicker(
                          name: 'Activity_Date_Time',
                        ),
                        Text("Pick your Activity Fitness Level"),
                        FormBuilderSlider(
                          name: 'Activity_Fitness_Level',
                          max: 100.0,
                          min: 0.0,
                          divisions: 5,
                          activeColor: HexColor("#EB9661"),
                          label: getLabel(_defaultActivityLevel, "Fitness"),
                          initialValue: _defaultActivityLevel,
                          onChanged: (val) => {
                            setState(() {
                              _defaultActivityLevel = val;
                            })
                          },
                        ),
                        Text("Pick your Activity Intensity Level"),
                        FormBuilderSlider(
                          name: 'Activity_Fitness_Level',
                          max: 100.0,
                          min: 0.0,
                          divisions: 5,
                          activeColor: HexColor("#EB9661"),
                          label: getLabel(_defaultIntensity, "Intensity"),
                          initialValue: _defaultIntensity,
                          onChanged: (val) => {
                            setState(() {
                              _defaultIntensity = val;
                            })
                          },
                        ),
                        Text("Pick your Activity Budget Level"),
                        FormBuilderSlider(
                          name: 'Activity_Fitness_Level',
                          max: 100.0,
                          min: 0.0,
                          divisions: 5,
                          activeColor: HexColor("#EB9661"),
                          label: getLabel(_defaultBudgetLevel, "Budget"),
                          initialValue: _defaultBudgetLevel,
                          onChanged: (val) => {
                            setState(() {
                              _defaultBudgetLevel = val;
                            })
                          },
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
                                      border: Border.all(
                                          color: HexColor('#C8C8C8'))),
                                  child: FlatButton(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            resource,
                                            style: TextStyle(fontSize: 11.0),
                                          )
                                        ]),
                                    color:
                                        widget.user.resources.contains(resource)
                                            ? HexColor('#EB9661')
                                            : Colors.transparent,
                                    onPressed: () => {
                                      if (!widget.user.resources
                                          .contains(resource))
                                        {widget.user.resources.add(resource)}
                                      else
                                        {
                                          widget.user.resources.remove(resource)
                                        },
                                      setState(() => {})
                                    },
                                  ),
                                );
                              }).toList()),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: HexColor("#FFFFFF"),
                              onPressed: () => {},
                              child: Text(
                                "Create",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      },
      "Budget": {
        0: "Free",
        20: "Slightly Expensive",
        40: "Moderately Expensive",
        60: "Expensive",
        80: "Very Expensive",
        100: "Super Expensive"
      }
    };
    return modes[mode][percLevel];
  }
}
