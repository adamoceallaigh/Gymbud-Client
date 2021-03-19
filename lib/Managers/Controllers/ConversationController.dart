// Imports

// Library Imports
import 'package:dio/dio.dart';
import 'dart:convert';

// Page Imports
import 'package:Client/Models/Conversation.dart';

class ConversationController {
  // Variable to hold the amount of conversations throughout app
  List<Conversation> conversations = [];

  // Variable to hold the url in use throughout the app
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  ConversationController(String url) {
    this.url_in_use = '$url/conversations';
  }

  // Encoding and decoding the list of conversations
  static String encodeConversationListToConversationsString(
      List<Conversation> conversations) {
    return json.encode(
      conversations
          .map<Map<String, dynamic>>(
              (conversation) => Conversation.toJson(conversation))
          .toList(),
    );
  }

  static List<Conversation> decodeUserStringToUserList(String conversations) {
    return (json.decode(conversations) as List<dynamic>)
        .map<Conversation>((item) => Conversation.fromJSON(item))
        .toList();
  }

  Future<List<Conversation>> readConversations() async {
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var conversationsJSON = response.data;
      for (var userJSON in conversationsJSON) {
        conversations.add(Conversation.fromJSON(userJSON));
      }
      //conversationsJSON.map((user) => conversations.add(User.fromJSON(user)));
    }

    return conversations;
  }
}
