// Imports

// Library Imports

import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/GeneralNetworkingMethodManager.dart';
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';

// Template to make the UpdateProfile View Page
class UpdateProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager =
        GeneralHelperMethodManager(logged_in_user: logged_in_user);

    return Scaffold(
        body: generalHelperMethodManager.getUpdateProfilePageBody());
  }
}

// import 'package:flutter_switch/flutter_switch.dart';
// bool isProfileSettings = false;
// FlutterSwitch(
//   activeText: "Profile",
//   inactiveText: "Activity Settings",
//   value: isProfileSettings,
//   valueFontSize: 10.0,
//   width: 410,
//   borderRadius: 30.0,
//   showOnOff: true,
//   onToggle: (val) {
//     setState(() {
//       isProfileSettings = val;
//     });
//   },
// ),
