// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Models/User.dart';

// Template to make the GymbudPlus View Page
class GymbudPlusView extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  GymbudPlusView({Key key, this.user}) : super(key: key);

  @override
  _GymbudPlusViewState createState() => _GymbudPlusViewState();
}

// State to manage the template for this page
class _GymbudPlusViewState extends State<GymbudPlusView> {
  /*
    Setting up variables for this page
  */

  // Logic Functions

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
