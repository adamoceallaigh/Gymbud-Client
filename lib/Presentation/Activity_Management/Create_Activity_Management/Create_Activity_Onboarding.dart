// Imports

// Library Imports
import 'package:Client/Helpers/GeneralComponents.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

// Page Imports
import 'package:Client/Presentation/Activity_Management/Create_Activity_Management/Create_Activity.dart';
import 'package:Client/Config/configVariables.dart' as Constants;

class AddActivityOnboarding extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /*
      Setting up our variables
    */

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 1100,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 180,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              height: 90,
                              width: 93,
                              child: SvgPicture.asset(
                                'Resources/Images/Gymbud_Logo.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text('What sort of activity are you setting up ?'),
                Text('Please pick from one of the options below'),
                Container(
                  child: Column(
                    children: [
                      SelectFromOptionsWidget(
                        generalOptions:
                            Constants.ActivityVariableStore.mainActivityOptions,
                        placeToChangeFrom: "Activity",
                        whatToChange: "Type",
                      )
                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddActivity(),
                          ),
                        ),
                      },
                      child: Text(
                        "Continue",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
