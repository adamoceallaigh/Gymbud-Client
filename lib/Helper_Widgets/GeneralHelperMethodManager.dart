// Imports

// Library Imports
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

// Page Imports
import 'package:Client/Controllers/ActivityController.dart';
import 'package:Client/Controllers/UserController.dart';

// Class To upload Photos to the Backend
class GeneralHelperMethodManager {
  // Upload Image file to server
  // static Future<String> uploadImage(File _image) async {
  //   try {
  //     const downloadURL =
  //   } catch (e) {
  //     print('caught error $e');
  //   }
  //   return null;
  // }
  static storeValuesInPreferences(Map<String, List<dynamic>> dataList) async {
    // Setting up the app with a network manager and general helper manager
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = identifyValuesPassedIntoPreferences(
        dataList.keys.elementAt(0), dataList.values.elementAt(0));
    await prefs.setString(dataList.keys.elementAt(0), encodedData);
    print(encodedData);
    print(dataList);
  }

  static String identifyValuesPassedIntoPreferences(
      String object_identifier, List<dynamic> dynamicListValues) {
    switch (object_identifier) {
      case "users":
        return UserController.encodeUserListToUsersString(dynamicListValues);
      case "activities":
        return ActivityController.encodeActivityListToActivitiesString(
            dynamicListValues);
    }
  }
}
