// Imports

// Library Imports
import 'package:Client/Presentation/User_Management/Create_User_Management/Create_User_Details_Success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/HexColor.dart';

// Template for Details Page
class DetailsPage extends StatefulWidget {
  /*  
    Setting up variables for this page
   */

  // This is the way we are going to save the values across the pages
  final User user;
  DetailsPage({Key key, @required this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  /*  
    Setting up variables for this page
  */

  // Basic details up form key to be used for validation and on this page
  final _basicDetailsSignUpKey = GlobalKey<FormBuilderState>();

  // Styling for continue button
  ButtonStyle continue_btn = ButtonProducer.getOrangeGymbudBtn();

  // Variable to hold my gender options
  List<String> genderOptions = [
    "Male",
    "Female",
    "Prefer Not To Say",
    "Non-Binary"
  ];

  // Varaiables to track the inputs of the user throughout the form
  RangeValues _ageValues = RangeValues(18, 90);
  double _distanceValue = 5.0;

  // Logic Functions
  setBasicDetailsValues(Map<String, dynamic> formValues, BuildContext context) {
    widget.user.name = formValues["Name"];
    widget.user.dob = formValues["DOB"].toString().split(" ").first;
    widget.user.gender = formValues["Gender"];
    print(widget.user);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPageSuccess(user: widget.user),
      ),
    );
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Container(
            child: Image.asset(
              'Resources/Images/logoGymbud.png',
            ),
          ),
          backgroundColor: HexColor("FEFEFE"),
        ),
        body: retrieveBody(context));
  }

  // Retrieve Body for Basic Details Page
  Widget retrieveBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 880,
        child: FormBuilder(
          key: _basicDetailsSignUpKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              if (widget.user.profileUrl != null)
                Container(
                  height: 150,
                  width: 200,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.user.profileUrl),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:"),
                      FormBuilderTextField(
                        name: 'Name',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 8)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DOB:"),
                      FormBuilderDateTimePicker(
                        name: 'DOB',
                        lastDate: DateTime(DateTime.now().year - 18),
                        initialDate: DateTime(1970),
                        inputType: InputType.date,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender:"),
                      FormBuilderDropdown(
                        name: 'Gender',
                        // initialValue: 'Male',
                        allowClear: true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: genderOptions
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text('$gender'),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Age Range:"),
                      Text("18-31"),
                      SliderTheme(
                        data: SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: RangeSlider(
                          values: _ageValues,
                          min: 0,
                          max: 100,
                          labels: RangeLabels('${_ageValues.start.round()}',
                              '${_ageValues.end.round()}'),
                          inactiveColor: Colors.grey,
                          activeColor: HexColor('#EB9661'),
                          onChanged: (RangeValues values) {
                            print(
                                'START: ${_ageValues.start.round()}, END: ${_ageValues.end.round()}');
                            setState(() {
                              widget.user.preferredAgeRange =
                                  '${_ageValues.start} - ${_ageValues.end}';
                              _ageValues = values;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Maximum Distance:"),
                      Text("20 mi"),
                      SliderTheme(
                        data: SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: Slider(
                          value: _distanceValue,
                          min: 0,
                          max: 100,
                          label: '${_distanceValue.round()}',
                          inactiveColor: Colors.grey,
                          activeColor: HexColor('#EB9661'),
                          onChanged: (double value) {
                            print('${_distanceValue.round()}');
                            setState(() {
                              widget.user.preferredDistanceRange =
                                  '${_distanceValue.round()}';
                              _distanceValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              createContinueToBasicDetailsPageBtn(context)
            ]),
          ),
        ),
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
          //Check if the form is validated
          if (_basicDetailsSignUpKey.currentState.saveAndValidate()) {
            setBasicDetailsValues(
              _basicDetailsSignUpKey.currentState.value,
              context,
            );
          }
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Continue",
            style: GoogleFonts.concertOne(
              fontSize: 30,
              // letterSpacing: -1.5,
            ),
          ),
        ),
      ),
    );
  }
}
