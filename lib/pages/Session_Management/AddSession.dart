import 'package:Client/Controllers/SessionController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/Session.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/MatchView.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void setUpSession(Map<String, dynamic> formValues) async {
    final formattedDate =
        DateFormat('yyyy-MM-dd kk:mm').format(formValues['Activity_Date_Time']);
    // ['id'] = widget.user._id;
    widget.session.activityName = formValues['Workout_Name'];
    widget.session.activityDescription = formValues['Workout_Description'];
    widget.session.activityGenderPreference = formValues['Gender_Preference'];
    widget.session.date = formattedDate.split(" ")[0];
    widget.session.time = formattedDate.split(" ")[1];
    widget.session.activityIntensityLevel =
        getLabel(formValues['Activity_Intensity_Level'], "Intensity");
    widget.session.duration = formValues['Activity_Duration'];
    widget.session.creator = widget.user;
    widget.session.participants = [widget.user];
    widget.session.activityBudgetLevel =
        getLabel(formValues['Activity_Budget_Level'], "Budget");
    widget.session.activityFitnessLevel =
        getLabel(formValues['Activity_Fitness_Level'], "Fitness");
    widget.session.location = "4 Fraher Field, WestPort";
    widget.session.activityImageUrl =
        formValues['Activity_Image_Url'].toString();
    SessionController sessionController = new SessionController();
    bool isCreated = await sessionController.createsession(widget.session);
    if (isCreated == true)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchView(
            user: widget.user,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 3520,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 130,
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
                    height: 2570,
                    margin: EdgeInsets.all(10),
                    width: double.infinity - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type Of Activity",
                          style: GoogleFonts.meriendaOne(
                            color: HexColor("#000000"),
                            fontSize: 18,
                            letterSpacing: -1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            widget.session.activityType,
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#7A7A7A"),
                              fontSize: 17,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Name Of Workout",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FormBuilderTextField(
                            name: 'Workout_Name',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Description Of Workout",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FormBuilderTextField(
                            name: 'Workout_Description',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Looking to Workout With",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
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
                                  SvgPicture.asset(
                                      "Resources/Images/Female.svg"),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Date Time Picker",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FormBuilderDateTimePicker(
                            name: 'Activity_Date_Time',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            "Pick your Activity Fitness Level",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: FormBuilderSlider(
                            name: 'Activity_Fitness_Level',
                            max: 100.0,
                            min: 0.0,
                            divisions: 5,
                            activeColor: HexColor("#EB9661"),
                            label: getLabel(_defaultActivityLevel, "Fitness"),
                            initialValue: _defaultActivityLevel,
                            onChanged: (val) => {
                              // widget.session.
                              setState(() {
                                _defaultActivityLevel = val;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            "Pick your Activity Intensity Level",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: FormBuilderSlider(
                            name: 'Activity_Intensity_Level',
                            max: 100.0,
                            min: 0.0,
                            divisions: 5,
                            activeColor: HexColor("#EB9661"),
                            label: getLabel(_defaultIntensity, "Intensity"),
                            initialValue: _defaultIntensity,
                            onChanged: (val) => {
                              widget.session.activityIntensityLevel =
                                  getLabel(_defaultIntensity, "Intensity"),
                              setState(() {
                                _defaultIntensity = val;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            "Pick your Activity Budget Level",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: FormBuilderSlider(
                            name: 'Activity_Budget_Level',
                            max: 100.0,
                            min: 0.0,
                            divisions: 5,
                            activeColor: HexColor("#EB9661"),
                            label: getLabel(_defaultBudgetLevel, "Budget"),
                            initialValue: _defaultBudgetLevel,
                            onChanged: (val) => {
                              // widget.sess
                              setState(() {
                                _defaultBudgetLevel = val;
                              })
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the resources you have",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: SizedBox(
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
                                      color: widget.user.resources
                                              .contains(resource)
                                          ? HexColor('#EB9661')
                                          : Colors.transparent,
                                      onPressed: () => {
                                        if (!widget.user.resources
                                            .contains(resource))
                                          {widget.user.resources.add(resource)}
                                        else
                                          {
                                            widget.user.resources
                                                .remove(resource)
                                          },
                                        setState(() => {})
                                      },
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity duration",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FormBuilderTextField(
                            name: 'Activity_Duration',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity location",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity Image",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        FormBuilderImagePicker(
                          name: 'Activity_Image_Url',
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: HexColor("#FFFFFF"),
                              onPressed: () => {
                                if (_formKey.currentState.saveAndValidate())
                                  {
                                    setUpSession(_formKey.currentState.value),
                                  }
                              },
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
