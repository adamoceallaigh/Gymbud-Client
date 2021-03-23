// Imports

// Library Imports
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:google_fonts/google_fonts.dart';

// General Class for the Options Radio Buttons
class GeneralOption {
  String description;
  String imageName;
  bool isSelected;
  String hiddenText;

  GeneralOption(
      this.description, this.hiddenText, this.imageName, this.isSelected);
}

// Class Declaration for my Activity Options radio button
class Activity_Option extends GeneralOption {
  GeneralOption generalOption;
  Activity_Option(GeneralOption this.generalOption)
      : super(generalOption.description, generalOption.hiddenText,
            generalOption.imageName, generalOption.isSelected);
}

// Class Declaration for my Gender Options radio button
class Gender_Option extends GeneralOption {
  GeneralOption generalOption;
  Gender_Option(GeneralOption this.generalOption)
      : super(generalOption.description, generalOption.hiddenText,
            generalOption.imageName, generalOption.isSelected);
}

class GeneralOptionRadio extends StatelessWidget {
  // Variable to store instance of my activity radio button type
  final GeneralOption _general_option;

  GeneralOptionRadio(this._general_option);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      color: _general_option.isSelected ? HexColor("EB9661") : Colors.white,
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
              _general_option.imageName,
            ),
            SizedBox(height: 20),
            Text(
              _general_option.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _general_option.isSelected ? Colors.white : Colors.black,
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
