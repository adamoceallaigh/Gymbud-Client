// Imports

// Library Imports
import 'dart:convert';
import 'package:dio/dio.dart';

// Page Imports
import 'package:Client/Models/Activity.dart';

// Activity Controller Class Definition to conduct activity management operations
class ActivityController {
  // Variable to hold the list of activities throughout the methods
  List<Activity> activities = [];

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  ActivityController(String url) {
    this.url_in_use = url;
  }

  // Encoding and decoding the list of users
  static String encodeActivityListToActivitiesString(
      List<Activity> activities) {
    return json.encode(
      activities
          .map<Map<String, dynamic>>(
            (activity) => Activity.toJson(activity),
          )
          .toList(),
    );
  }

  static List<Activity> decodeActivitiesStringToActivityList(
      String activities) {
    return (json.decode(activities) as List<dynamic>)
        .map<Activity>((item) => Activity.fromJSON(item))
        .toList();
  }

  Future<bool> createactivity(Activity activity) async {
    try {
      Response response = await dio.post(
        '${this.url_in_use}/activities',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
        data: jsonEncode(Activity.toJson(activity)),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }

  Future<List<Activity>> readActivities() async {
    Response response = await dio.get('${this.url_in_use}/activities');
    if (response.statusCode == 200) {
      var activitiesJSON = response.data;
      for (var activityJSON in activitiesJSON) {
        activities.add(Activity.fromJSON(activityJSON));
      }
    }

    return activities;
  }

  Future<String> addUserToActivity(String activityId, String userId) async {
    Response response = await dio.post(
      '${this.url_in_use}/activities/addUser?activityId=$activityId&userId=$userId',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
      ),
      // withCredentials: true,
      data: jsonEncode({activityId: activityId}),
    );
    if (response.statusCode == 200) {
      var responseJSON = jsonDecode(response.data);
      return responseJSON[0];
    }
    return null;
  }
}
