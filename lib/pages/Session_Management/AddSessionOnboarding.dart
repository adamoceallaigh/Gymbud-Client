import 'package:Client/Models/Session.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/Session_Management/AddSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

class AddSessionOnboarding extends StatefulWidget {
  final User user;
  AddSessionOnboarding({Key key, this.user}) : super(key: key);

  @override
  _AddSessionOnboardingState createState() => _AddSessionOnboardingState();
}

class _AddSessionOnboardingState extends State<AddSessionOnboarding> {
  final _formKey = GlobalKey<FormBuilderState>();
  final sessionOptions = ["Home Workout", "Gym Workout", "Outdoor Activity"];

  @override
  Widget build(BuildContext context) {
    final newSession = new Session(
      id: widget.user.id,
      time: null,
      date: null,
      location: null,
      activityType: null,
      activityName: null,
      activityDescription: null,
      activityGenderPreference: null,
      videoOrInPerson: null,
      intensityLevel: null,
      activityImageUrl: null,
      resources: [],
      capacity: [],
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 1100,
            color: Colors.redAccent,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 180,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.yellowAccent,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              color: Colors.blueAccent,
                              height: 90,
                              width: 93,
                              child: SvgPicture.asset(
                                'Resources/Images/Gymbud_Logo.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text('What sort of activity are you setting up ?'),
                Text('Please pick from one of the options below'),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              SvgPicture.asset(
                                  "Resources/Images/Home_Workout.svg"),
                              Text("( A )")
                            ],
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              SvgPicture.asset(
                                  "Resources/Images/GymWeights.svg"),
                              Text("( B )")
                            ],
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              SvgPicture.asset(
                                  "Resources/Images/Outdoor_Act.svg"),
                              Text("( C )")
                            ],
                          ),
                        ],
                      ),
                      FormBuilder(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              child: FormBuilderRadioGroup(
                                name: 'Activity_Type',
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: sessionOptions
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
                      Text('( A )     Home Workout '),
                      Text('( B )     Gym Workout '),
                      Text('( C )     Outdoor Activity'),
                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () => {
                        if (_formKey.currentState.saveAndValidate())
                          {
                            print(_formKey.currentState.value['Activity_Type']),
                            newSession.activityType =
                                _formKey.currentState.value['Activity_Type'],
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSession(
                                    user: widget.user, session: newSession),
                              ),
                            ),
                          }
                      },
                      child: Text(
                        "Continue",
                      ),
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

  String getSessionOption(int index) {
    return sessionOptions[index];
  }
}
