// Imports

// Library Imports

// Page Imports
import 'package:Client/Models/Conversation.dart';

class ConversationController {
  // Variable to hold the amount of conversations throughout app
  List<Conversation> conversations = [];

  // Variable to hold the url in use throughout the app
  String url_in_use;

  ConversationController(String url) {
    this.url_in_use = url;
  }
}
