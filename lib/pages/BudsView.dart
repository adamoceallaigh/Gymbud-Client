// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Models/User.dart';

// Template to make the Buds View Page
class BudsView extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  BudsView({Key key, this.user}) : super(key: key);

  @override
  _BudsViewState createState() => _BudsViewState();
}

// State to manage the template for this page
class _BudsViewState extends State<BudsView> {
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
