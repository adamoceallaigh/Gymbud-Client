// Imports

// Library Imports
import 'dart:convert';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:dio/dio.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Activity.dart';

class ActivityController {
  // Variable to handle the error infopPopUp
  InformationPopUp infopPopUp;

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  ActivityController(AppState appState) {
    if (appState is AppLoaded) {
      this.url_in_use = '${appState.url}/activities';
      infopPopUp = InformationPopUp();
    }
  }

  Future<dynamic> createactivity(Activity activity) async {
    try {
      Response response = await dio.post(
        '${this.url_in_use}',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
        data: jsonEncode({
          "Time": activity.time,
          "Creator": {"_id": activity.creator.id},
          "Date": activity.date,
          "Location": activity.location,
          "Duration": activity.duration,
          "Activity_Type": activity.activityType,
          "Activity_Name": activity.activityName,
          "Activity_Description": activity.activityDescription,
          "Activity_Gender_Preference": activity.activityGenderPreference,
          "Intensity_Level": activity.activityIntensityLevel,
          "Fitness_Level": activity.activityFitnessLevel,
          "Budget_Level": activity.activityBudgetLevel,
          "Activity_Image_Url": activity.activityImageUrl,
          "Resources": activity.resources ?? [],
          "Participants": [activity.creator.id]
        }),
      );
      if (response.statusCode == 200) {
        var activityJSON = response.data;
        if (activityJSON != null) {
          // return Activity.fromJSON(activityJSON);
          return true;
        }
        if (activityJSON["cause"] != null) {
          return InformationPopUp(message: activityJSON["cause"][0]);
        }
      }
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }

  Future<List<Activity>> readActivities() async {
    List<Activity> activities = [];
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var activitiesJSON = response.data;
      for (var activityJSON in activitiesJSON) {
        activities.add(Activity.fromJSON(activityJSON));
      }
    }

    return activities;
  }

  Future<dynamic> addUserToActivity(String activityId, String userId) async {
    Response response = await dio.post(
      '${this.url_in_use}/addUser?activityId=$activityId&userId=$userId',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
      ),
      data: jsonEncode({activityId: activityId}),
    );
    if (response.statusCode == 200) {
      var activityJSON = response.data;
      if (activityJSON != null) {
        if (activityJSON["user"] != null) {
          return Activity.fromJSON(activityJSON["user"]);
        }
      }
      if (activityJSON["cause"] != null) {
        return InformationPopUp(message: activityJSON["cause"][0]);
      }
    }
    return null;
  }
}
