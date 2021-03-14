/*
  Imports
*/

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helper_Widgets/hex_color.dart';

// Class Declaration for Button Producer to give back styled buttons used in app
class ButtonProducer {
  // Orange Gymbud Button
  static getOrangeGymbudBtn() {
    return ElevatedButton.styleFrom(
      primary: HexColor("EB9661"),
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
