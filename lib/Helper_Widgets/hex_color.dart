// Imports
import 'package:flutter/material.dart';

// Helper Class to transform a Hexidecimal Color to an int which represents a Color to be used in Flutter 
class HexColor extends Color {

  // Takes a String(Hexidecimal Colour) and returns the integer associated with that ARG Color
  // Very handy method to convert Hexidecimal Colours to Color in Flutter
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  // Implies when instantiating a Hexcolor to run this method on string passed into constructor
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}