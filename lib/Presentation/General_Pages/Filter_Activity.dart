// Imports

// Library Imports
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/GeneralComponents.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:flutter/material.dart';

class FilterActivity extends StatefulWidget {
  @override
  _FilterActivityState createState() => _FilterActivityState();
}

class _FilterActivityState extends State<FilterActivity> {
  GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              ActivitySliders(context: context, place: "Activity"),
              ElevatedButton(
                onPressed: () => {},
                child: Text("Continue"),
                style: ButtonProducer.getFollowGymbudBtn(),
              )
            ],
          )),
    );
  }
}
