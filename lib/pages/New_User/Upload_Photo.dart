import 'dart:html';

import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:Client/Helper_Widgets/image_utils.dart';


class UploadPhoto extends StatelessWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  UploadPhoto({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
            title: Image.asset(
              "Resources/Images/logoGymbud.png",
              height: 100.0,
              width: 100.0
            ),
            backgroundColor: HexColor("FEFEFE"),
          ),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageCapture()
          ],
        ),
      ),
    );
  }
}