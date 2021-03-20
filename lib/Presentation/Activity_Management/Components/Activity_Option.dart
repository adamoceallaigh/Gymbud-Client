// Imports

// Library Imports
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:google_fonts/google_fonts.dart';

// Class Declaration for my Activity Option radio button
class Activity_Option {
  String description;
  String imageName;
  bool isSelected;
  String hiddenText;

  Activity_Option(
      this.description, this.hiddenText, this.imageName, this.isSelected);
}

class ActivityOptionRadio extends StatelessWidget {
  // Variable to store instance of my activity radio button type
  final Activity_Option _activity_option;

  ActivityOptionRadio(this._activity_option);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      color: _activity_option.isSelected ? HexColor("EB9661") : Colors.white,
      child: Container(
        height: 20,
        width: 110,
        alignment: Alignment.center,
        margin: new EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              _activity_option.imageName,
            ),
            SizedBox(height: 20),
            Text(
              _activity_option.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    _activity_option.isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.delius().fontFamily,
              ),
            )
          ],
        ),
      ),
    );
  }
}
