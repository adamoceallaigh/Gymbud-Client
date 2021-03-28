/*
  Imports
*/

// Library Imports
import 'dart:ui';

import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';

// Class Declaration for Button Producer to give back styled buttons used in app
class ButtonProducer {
  // Orange Gymbud Button
  static getOrangeGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("EB9661"),
      elevation: 2,
      fixedSize: Size(
        240,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static getFollowGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("EB9661"),
      elevation: 2,
      fixedSize: Size(
        170,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  static getLoginGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("2E2B2B"),
      elevation: 2,
      fixedSize: Size(
        210,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static getUploadImageGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("2E2B2B"),
      elevation: 2,
      fixedSize: Size(
        120,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static getSignUpGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("EB9661"),
      elevation: 2,
      fixedSize: Size(
        210,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static getMessageGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      elevation: 2,
      fixedSize: Size(
        170,
        50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  // White Gymbud Button With Border
  static getWhiteGymbudBtn(String border_color) {
    return ElevatedButton.styleFrom(
      primary: HexColor("FFFFFF"),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 2.0,
          color: HexColor(border_color),
        ),
      ),
    );
  }
}
