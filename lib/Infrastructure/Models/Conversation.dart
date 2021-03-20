// Imports

// Library Imports

// Page Impports
import 'package:Client/Infrastructure/Models/Message.dart';
import 'package:Client/Infrastructure/Models/User.dart';

class Conversation {
  // String variable to gather the id which is very important
  String id;

  // Variable to hold the amount of messages going to be in each conversation
  List<dynamic> messages = [];

  // Variable to hold the Sender and Reciever Message Objects
  dynamic receiver;
  dynamic sender;

  // Variable to hold the timestamps
  String createdAt;
  String updatedAt;

  // Optional Named Constructor for Conversation
  Conversation({this.messages, this.receiver, this.sender});

  // Constructor to pull json data values and make up a Conversation model
  Conversation.fromJSON(Map<String, dynamic> data) {
    this.id = data["_id"];
    this.messages = List<dynamic>.from(
      data['Messages'].map(
        (message) => message.runtimeType == String
            ? data["Messages"]
            : Message.fromJSON(message),
      ),
    );
    this.receiver = data["Receiver"].runtimeType == String
        ? data["Receiver"]
        : User.fromJSON(data["Receiver"]);
    this.sender = data["Sender"].runtimeType == String
        ? data["Sender"]
        : User.fromJSON(data["Sender"]);
    this.createdAt = data['createdAt'];
    this.updatedAt = data['updatedAt'];
  }

  static Map<String, dynamic> toJson(Conversation conversation) => {
        '_id': conversation.id,
        'Messages': conversation.messages,
        'Receiver': User.toJson(conversation.receiver),
        'Sender': User.toJson(conversation.sender),
      };

  @override
  String toString() {
    return Conversation.toJson(this).toString();
  }
}
