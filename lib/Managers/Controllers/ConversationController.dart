// Imports

// Library Imports
import 'dart:convert';

import 'package:Client/Infrastructure/Models/Message.dart';
import 'package:dio/dio.dart';

// Page Imports
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:Client/Infrastructure/Models/Conversation.dart';

class ConversationController {
  // Variable to hold the url in use throughout the app
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  ConversationController(AppState appState) {
    if (appState is AppLoaded) {
      this.url_in_use = '${appState.url}/conversations';
    }
  }

  Future<List<Conversation>> readConversations() async {
    List<Conversation> conversations = [];
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var conversationsJSON = response.data;
      for (var userJSON in conversationsJSON) {
        conversations.add(Conversation.fromJSON(userJSON));
      }
    }

    return conversations;
  }

  Future<Conversation> readConversationById(Conversation conversation) async {
    try {
      Response response = await dio.get(
        '${this.url_in_use}/${conversation.id}',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
      );
      var conversationJSON = response.data;
      if (response.statusCode == 200) {
        if (conversationJSON != null) {
          return Conversation.fromJSON(conversationJSON);
        }
        if (conversationJSON["cause"] != null) {
          // this.infopPopUp = InformationPopUp(message: conversationJSON["cause"][0]);
          // return infopPopUp;
        }
      }
    } catch (e) {
      print('caught error $e');
    }
  }

  void createMessage(
      Message newMessage, Conversation current_conversation) async {
    try {
      await dio.post(
        '${this.url_in_use}/${current_conversation.id}/new_message',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
        ),
        data: jsonEncode(
          {
            "Content": newMessage.content,
            'Sender': {
              'senderName': newMessage.sender.senderName,
              'senderId': newMessage.sender.senderId
            }
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
