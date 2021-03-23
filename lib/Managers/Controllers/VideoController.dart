// Imports

// Library Imports
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

// Page Imports
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:uuid/uuid.dart';

class VideoController {
  // Variable to handle the error infopPopUp
  InformationPopUp infopPopUp;

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  VideoController(AppState appState) {
    if (appState is AppLoaded) {
      this.url_in_use = '${appState.url}/users';
      infopPopUp = InformationPopUp();
    }
  }

  String createVideoLink() {
    final randomId = new Uuid();
    return 'http://localhost:3300/${randomId}';
  }
}
