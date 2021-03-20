// Imports

// Library Imports
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

// Page Imports
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Infrastructure/Models/User.dart';

class UserController {
  // Variable to handle the error infopPopUp
  InformationPopUp infopPopUp;

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  UserController(AppState appState) {
    if (appState is AppLoaded) {
      this.url_in_use = '${appState.url}/users';
      infopPopUp = InformationPopUp();
    }
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
        return User.fromJSON(userJSON["user"]);
        // notifyListeners();
      }
      if (userJSON["cause"] != null) {
        return InformationPopUp(message: userJSON["cause"][0]);
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
        return User.fromJSON(userJSON["user"]);
      }
      if (userJSON["cause"] != null) {
        return InformationPopUp(message: userJSON["cause"][0]);
      }
    }
  }

  Future<List<User>> readUsers() async {
    Response response = await dio.get('${this.url_in_use}');
    List<User> users = [];
    if (response.statusCode == 200) {
      var usersJSON = response.data;
      for (var userJSON in usersJSON) {
        users.add(User.fromJSON(userJSON));
        return users;
      }
    }
    return null;
  }

  Future<dynamic> readSingleUser(String username, String password) async {
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
          return User.fromJSON(userJSON["user"]);
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
