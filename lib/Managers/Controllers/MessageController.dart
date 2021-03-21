// Imports

// Library Imports
import 'package:dio/dio.dart';
import 'dart:convert';

// Page Imports
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Infrastructure/Models/Message.dart';

// Message Controller Class Definition to conduct message management operations
class MessageController {
  // Variable to hold the list of messages throughout the methods
  List<Message> messages = [];

  // Variable to hold the url in use
  String url_in_use;

  // Variable to hold instance of dio used for networking
  Dio dio = new Dio();

  MessageController(String url) {
    this.url_in_use = '$url/messages';
  }

  Future<dynamic> createMessage(Message message) async {
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
        Message.toJson(message),
      ),
    );

    var messageJSON = response.data;
    if (response.statusCode == 200) {
      if (messageJSON["message"] != null)
        return Message.fromJSON(messageJSON["message"]);
      if (messageJSON["cause"] != null)
        return new InformationPopUp(message: messageJSON["cause"][0]);
    }
    return null;
  }

  Future<dynamic> updateMessage(Message message) async {
    Response response = await dio.put(
      '${this.url_in_use}/${message.id}',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
      ),
      data: jsonEncode(
        Message.toJson(message),
      ),
    );

    var messageJSON = response.data;
    if (response.statusCode == 200) {
      if (messageJSON["message"] != null)
        return Message.fromJSON(messageJSON["message"]);
      if (messageJSON["cause"] != null)
        return new InformationPopUp(message: messageJSON["cause"][0]);
    }
    return null;
  }

  Future<List<Message>> readMessages() async {
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var messagesJSON = response.data;
      for (var messageJSON in messagesJSON) {
        messages.add(Message.fromJSON(messageJSON));
      }
    }

    return messages;
  }
}
