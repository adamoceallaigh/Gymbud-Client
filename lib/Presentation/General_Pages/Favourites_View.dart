// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';

// Template to make the Favourites View Page
class FavouritesView extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  FavouritesView({Key key, this.user}) : super(key: key);

  @override
  _FavouritesViewState createState() => _FavouritesViewState();
}

// State to manage the template for this page
class _FavouritesViewState extends State<FavouritesView> {
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
