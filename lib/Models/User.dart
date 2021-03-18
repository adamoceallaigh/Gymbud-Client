//Class Declaration of the Class Model

import 'dart:convert';

import 'package:Client/Models/Activity.dart';
import 'package:Client/Models/Conversation.dart';

class User {
  // Variables to hold all user values
  String id,
      username,
      email,
      password,
      profileUrl,
      name,
      gender,
      dob,
      preferredIntensity,
      preferredAgeRange,
      preferredDistanceRange,
      preferredActivity,
      fitnessLevel;
  List<String> resources, activitiesEnjoyed;
  List<User> buds;
  List<Activity> activities;
  List<Conversation> conversations;

  // Variable to hold instance variable of user
  static Future<User> getUserInstance() async {
    return new User();
  }

  // Optional Named Constructor for User
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.profileUrl,
    this.name,
    this.gender,
    this.dob,
    this.preferredIntensity,
    this.preferredAgeRange,
    this.preferredDistanceRange,
    this.preferredActivity,
    this.fitnessLevel,
    this.buds,
    this.activities,
    this.resources,
    this.activitiesEnjoyed,
    this.conversations,
  });

  User.register(
    this.username,
    this.email,
    this.password,
    this.profileUrl,
    this.name,
    this.gender,
    this.dob,
    this.preferredIntensity,
    this.preferredAgeRange,
    this.preferredDistanceRange,
    this.preferredActivity,
    this.fitnessLevel,
    this.buds,
    this.activities,
    this.resources,
    this.activitiesEnjoyed,
    this.conversations,
  );

  User.login(
    this.username,
    this.password,
  );

  //Constructor to pull json data values and make up a User model
  User.fromJSON(Map<String, dynamic> data) {
    this.id = data["_id"];
    this.username = data['Username'];
    this.email = data["Email"];
    this.password = data['Password'];
    this.profileUrl = data['Profile_Url'];
    this.name = data['Name'];
    this.gender = data["Gender"];
    this.dob = data["DOB"];
    this.preferredIntensity = data["Preferred_Intensity"];
    this.preferredAgeRange = data["Preferred_Age_Range"];
    this.preferredDistanceRange = data["Preferred_Distance_Range"];
    this.preferredActivity = data["Preferred_Activity"];
    this.fitnessLevel = data["Fitness_Level"];
    this.buds = List<User>.from(data["Buds"].map((bud) => User.fromJSON(bud)));
    this.activities = List<Activity>.from(
        data["Activities"].map((activity) => Activity.fromJSON(activity)));
    this.resources = List<String>.from(
        data["Resources"].map((resource) => json.decode(resource)));
    this.activitiesEnjoyed = List<String>.from(data["Activities_Enjoyed"]
        .map((activity_enjoyed) => json.decode(activity_enjoyed)));
    this.conversations = List<Conversation>.from(data["Conversations"]
        .map((conversation) => Conversation.fromJSON(conversation)));
  }

  static Map<String, dynamic> toJson(User user) => {
        '_id': user.id,
        'Username': user.username,
        'Email': user.email,
        'Password': user.password,
        'Profile_Url': user.profileUrl,
        'Name': user.name,
        'Gender': user.gender,
        'DOB': user.dob,
        'Preferred_Intensity': user.preferredIntensity,
        'Fitness_Level': user.fitnessLevel,
        'Resources': user.resources,
        'Preferred_Age_Range': user.preferredAgeRange,
        'Preferred_Distance_Range': user.preferredDistanceRange,
        'Preferred_Activity': user.preferredActivity,
        'Conversations': user.conversations,
        'Activities_Enjoyed': user.activitiesEnjoyed,
        'Buds': user.buds,
        'Activities': user.activities
      };

  @override
  String toString() {
    return User.toJson(this).toString();
  }
}
