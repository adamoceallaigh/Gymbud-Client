// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Managers/Controllers/ActivityController.dart';
import 'package:Client/Managers/Controllers/ConversationController.dart';
import 'package:Client/Managers/Controllers/ImageController.dart';
import 'package:Client/Managers/Controllers/UserController.dart';

// Setting up providers
var userProvider, activityProvider, conversationProvider, imageProvider;

class GeneralNetworkingMethodManager {
  // Making the class variables to hold all the url's
  String local_ios_url = "http://localhost:7000";
  String local_android_url = "http://10.0.2.2:7000";
  String heroku_url = "https://gymbud.herokuapp.com";
  String url_in_use;

  // Variable to hold whether local or production is turned on
  bool production = false;

  // Variables to make new instance of the Models Controllers
  UserController user_controller;
  ActivityController activity_controller;
  ConversationController conversation_controller;
  ImageController image_controller;

  GeneralNetworkingMethodManager(BuildContext context) {
    if (this.production)
      this.url_in_use = this.heroku_url;
    else {
      if (Theme.of(context).platform == TargetPlatform.iOS)
        this.url_in_use = this.local_ios_url;
      else
        this.url_in_use = this.local_android_url;
    }
    userProvider =
        Provider<UserController>((ref) => UserController(this.url_in_use));
    activityProvider = Provider<ActivityController>(
        (ref) => ActivityController(this.url_in_use));
    conversationProvider = Provider<ConversationController>(
        (ref) => ConversationController(this.url_in_use));
    imageProvider =
        Provider<ImageController>((ref) => ImageController(this.url_in_use));
  }

  ImageController getImageController() {
    return this.image_controller;
  }

  UserController getUserController() {
    return this.user_controller;
  }

  ActivityController getActivityController() {
    return this.activity_controller;
  }

  ConversationController getConversationController() {
    return this.conversation_controller;
  }
}
