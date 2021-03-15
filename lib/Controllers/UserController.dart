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

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  UserController(String url) {
    this.url_in_use = '$url/users';
  }

  // Encoding and decoding the list of users
  static String encodeUserListToUsersString(List<User> users) {
    return json.encode(
      users.map<Map<String, dynamic>>((user) => User.toJson(user)).toList(),
    );
  }

  static List<User> decodeUserStringToUserList(String users) {
    return (json.decode(users) as List<dynamic>)
        .map<User>((item) => User.fromJSON(item))
        .toList();
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
      if (userJSON["user"] != null) return User.fromJSON(userJSON["user"]);
      if (userJSON["cause"] != null)
        return new InformationPopUp(message: userJSON["cause"][0]);
    }
    return null;
  }

  Future<List<User>> readUsers() async {
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var usersJSON = response.data;
      for (var userJSON in usersJSON) {
        users.add(User.fromJSON(userJSON));
      }
      //usersJSON.map((user) => users.add(User.fromJSON(user)));
    }

    return users;
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
        if (userJSON["user"] != null) return User.fromJSON(userJSON["user"]);
        if (userJSON["cause"] != null)
          return new InformationPopUp(message: userJSON["cause"][0]);
      }
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }
}
