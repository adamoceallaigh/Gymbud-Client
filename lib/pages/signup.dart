//Imports and Variable Declarations
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<String> _intensities = [
        "Very Intensive",
        "Intensive",
        "Moderately Intensive",
        "Low Intensity"
      ],
      _fitnessLevels = [
        "Very Active",
        "Active",
        "Moderately Active",
        "Inactive"
      ],
      _genders = [
        "Male",
        "Female",
        "Other",
        "Prefer not to Say",
      ],
      _sessionOptions = [
        "Video",
        "In Person",
      ];
  
  var _resources = [];
  var _selectedIntensity,
      _selectedFitnessLevel,
      _selectedGender,
      _selectedSessionOption;
  var _selectedBenchResource = false;
  var _selectedBandResource = false;
  var _selectedWeightResource = false;
  var _selectedRopeResource = false;
  var _ageRange = 18.0;
  var _selectedName, 
  _selectedPassword, 
  _selectedUsername, 
  _selectedDOB;

  void _setValues() async{ 
    UserController userController = new UserController();
    User newUser = new User.register(
        _selectedUsername, 
        _selectedPassword, 
        _selectedName, 
        _selectedGender,
        _selectedDOB,
        _selectedIntensity,
        _ageRange.toString(),
        _selectedSessionOption,
        _selectedFitnessLevel,
        [],
        [],
        _resources,
        []
      );
    newUser = await userController.createUser(newUser);
    if(newUser != null){
      Navigator.pushReplacementNamed(context , '/Home');
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 10,
              child: Image.asset('Resources/Images/logoGymbud.png',
                  height: 100, width: 100),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Name:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  TextField(
                    onSubmitted: (newText) { 
                      _selectedName = newText; 
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Username:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  TextField(
                    onSubmitted: (newText) { 
                    _selectedUsername = newText; 
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Password:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  TextField(
                    onSubmitted: (newText) { 
                      _selectedPassword = newText; 
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Gender:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  DropDownField(
                      onValueChanged: (dynamic value) {
                        _selectedGender = value;
                      },
                      value: _selectedGender,
                      required: true,
                      hintText: 'Choose a Gender',
                      labelText: 'Gender',
                      items: _genders),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30, left: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("DOB:",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                    ),
                  ),
                  TextField(
                    onChanged: (newText) { 
                      _selectedDOB = newText; 
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Preferred Session Intensity:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  DropDownField(
                      onValueChanged: (dynamic value) {
                        _selectedIntensity = value;
                      },
                      value: _selectedIntensity,
                      required: true,
                      hintText: 'Choose your preferred Session Intensity',
                      labelText: 'Session Intensity',
                      items: _intensities),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Appropriate fitness level:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  DropDownField(
                      onValueChanged: (dynamic value) {
                        _selectedFitnessLevel = value;
                      },
                      value: _selectedFitnessLevel,
                      required: true,
                      hintText: 'Choose your appropriate fitness level',
                      labelText: 'Fitness Level',
                      items: _fitnessLevels),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Resources available to you:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  CheckboxListTile(
                    title: Text("Bench"),
                    value: _selectedBenchResource,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBenchResource = newValue;
                        if (_selectedBenchResource) {
                          _resources.add("Bench");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Resistance Band"),
                    value: _selectedBandResource,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBandResource = newValue;
                        if (_selectedBandResource) {
                          _resources.add("Resistance Band");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Weights"),
                    value: _selectedWeightResource,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedWeightResource = newValue;
                        if (_selectedWeightResource) {
                          _resources.add("Weights");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Rope"),
                    value: _selectedRopeResource,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRopeResource = newValue;
                        if (_selectedRopeResource) {
                          _resources.add("Rope");
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30, left: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Preferred Age Range:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  Slider(
                      value: _ageRange,
                      onChanged: (newRange) {
                        setState(() {
                          _ageRange = newRange;
                        });
                      },
                      label: "$_ageRange",
                      divisions: 7,
                      min: 18.0,
                      max: 25.0),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10 ,bottom: 10.0 , top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Preferred Session Method:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  DropDownField(
                    onValueChanged: (dynamic value) {
                      _selectedSessionOption = value;
                    },
                    value: _selectedSessionOption,
                    required: true,
                    hintText: 'Choose your preferred session method',
                    labelText: 'Session Method',
                    items: _sessionOptions,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0 , top: 10.0),
              child: RaisedButton(
                child: Text('SignUp'), 
                onPressed: () => {
                    _setValues()
                  // _submitForm(_selectedUsername , )
                }
              ),
            )
          ],
        ));
  }
}
