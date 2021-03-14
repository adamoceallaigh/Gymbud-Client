// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Controllers/ActivityController.dart';
import 'package:Client/Controllers/ConversationController.dart';
import 'package:Client/Controllers/UserController.dart';

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

  GeneralNetworkingMethodManager(BuildContext context) {
    if (this.production)
      this.url_in_use = this.heroku_url;
    else {
      if (Theme.of(context).platform == TargetPlatform.iOS)
        this.url_in_use = this.local_ios_url;
      else
        this.url_in_use = this.local_android_url;
    }
    this.user_controller = new UserController(this.url_in_use);
    this.activity_controller = new ActivityController(this.url_in_use);
    this.conversation_controller = new ConversationController(this.url_in_use);
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
