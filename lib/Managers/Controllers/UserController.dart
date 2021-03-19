// Imports

// Library Imports
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// Page Imports
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/Models/User.dart';

// User Controller Class Definition to conduct user management operations
class UserController {
  // Variable to hold the list of users throughout the methods
  List<User> users = [];

  // Variable to handle the loggedInUser
  User loggedInUser;

  // Variable to handle the error infopPopUp
  InformationPopUp infopPopUp;

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio(BaseOptions());

  UserController(String platformUrl) {
    this.url_in_use = '$platformUrl/users';
    loggedInUser = User();
    infopPopUp = InformationPopUp();
  }

  Future<dynamic> createUser(User user) async {
    Response response = await dio.post(
      '${this.url_in_use}',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
      ),
      data: jsonEncode(
        User.toJson(user),
      ),
    );

    var userJSON = response.data;
    if (response.statusCode == 200) {
      if (userJSON["user"] != null) {
        this.loggedInUser = User.fromJSON(userJSON["user"]);
        // notifyListeners();
      }
      if (userJSON["cause"] != null) {
        this.infopPopUp = InformationPopUp(message: userJSON["cause"][0]);
      }
    }
  }

  Future<dynamic> updateUser(User user) async {
    Response response = await dio.put(
      '${this.url_in_use}/${user.id}',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
      ),
      data: jsonEncode(
        User.toJson(user),
      ),
    );

    var userJSON = response.data;
    if (response.statusCode == 200) {
      if (userJSON["user"] != null) {
        this.loggedInUser = User.fromJSON(userJSON["user"]);
      }
      if (userJSON["cause"] != null) {
        this.infopPopUp = InformationPopUp(message: userJSON["cause"][0]);
      }
    }
  }

  Future<List<User>> readUsers() async {
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var usersJSON = response.data;
      for (var userJSON in usersJSON) {
        this.users.add(User.fromJSON(userJSON));
        return users;
      }
    }
    return null;
  }

  Future<dynamic> readSingleUser(
      String username, String password, BuildContext context) async {
    try {
      Response response = await dio.post(
        '${this.url_in_use}/login',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
        data: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      var userJSON = response.data;
      if (response.statusCode == 200) {
        if (userJSON["user"] != null) {
          this.loggedInUser = User.fromJSON(userJSON["user"]);
          return loggedInUser;
        }
        if (userJSON["cause"] != null) {
          this.infopPopUp = InformationPopUp(message: userJSON["cause"][0]);
          return infopPopUp;
        }
      }
    } catch (e) {
      print('caught error $e');
    }
  }
}
