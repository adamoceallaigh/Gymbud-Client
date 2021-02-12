import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'Details_Success.dart';

class DetailsPage extends StatefulWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  DetailsPage({Key key, @required this.user}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  RangeValues _ageValues = RangeValues(5, 90);
  RangeValues _distanceValues = RangeValues(5, 90);
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();

  void setTextControllers(_name, _dob, _gender) {
    widget.user.name = _name;
    widget.user.dob = _dob;
    widget.user.gender = _gender;

    setState(() {
      _nameController = new TextEditingController(text: widget.user.name);
      _dobController = new TextEditingController(text: widget.user.dob);
      _genderController = new TextEditingController(text: widget.user.gender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("Resources/Images/logoGymbud.png",
            height: 100.0, width: 100.0),
        backgroundColor: HexColor("FEFEFE"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Text("Name:"),
            TextField(
              controller: _nameController,
            ),
            Text("DOB:"),
            TextField(
              controller: _dobController,
            ),
            Text("Gender:"),
            TextField(
              controller: _genderController,
            ),
            Text("Age Range:"),
            Text("18-31"),
            SliderTheme(
              data: SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always),
              child: RangeSlider(
                values: _ageValues,
                min: 0,
                max: 100,
                labels: RangeLabels(
                    '${_ageValues.start.round()}', '${_ageValues.end.round()}'),
                inactiveColor: Colors.grey,
                activeColor: HexColor('#EB9661'),
                onChanged: (RangeValues values) {
                  print(
                      'START: ${_ageValues.start.round()}, END: ${_ageValues.end.round()}');
                  setState(() {
                    setTextControllers(_nameController.text,
                        _dobController.text, _genderController.text);
                    widget.user.preferredAgeRange =
                        '${_ageValues.start} - ${_ageValues.end}';
                    _ageValues = values;
                  });
                },
              ),
            ),
            Text("Maximum Distance:"),
            Text("20 mi"),
            SliderTheme(
              data: SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always),
              child: RangeSlider(
                values: _distanceValues,
                min: 0,
                max: 100,
                labels: RangeLabels('${_distanceValues.start.round()}',
                    '${_distanceValues.end.round()}'),
                inactiveColor: Colors.grey,
                activeColor: HexColor('#EB9661'),
                onChanged: (RangeValues values) {
                  print(
                      'START: ${_distanceValues.start.round()}, END: ${_distanceValues.end.round()}');
                  setState(() {
                    setTextControllers(_nameController.text,
                        _dobController.text, _genderController.text);
                    widget.user.preferredDistanceRange =
                        '${_ageValues.start} - ${_ageValues.end}';
                    _distanceValues = values;
                  });
                },
              ),
            ),
            RaisedButton(
                child: Text("Continue"),
                onPressed: () => {
                      widget.user.name = _nameController.text,
                      widget.user.dob = _dobController.text,
                      widget.user.gender = _genderController.text,
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsPageSuccess(user: widget.user)),
                      ),
                    }),
          ]),
        ),
      ),
    );
  }
}
