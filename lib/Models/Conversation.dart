// Imports

// Library Imports

// Page Impports
import 'package:Client/Models/Message.dart';
import 'package:Client/Models/User.dart';

class Conversation {
  // Variable to hold the amount of messages going to be in each conversation
  List<Message> messages = [];

  // Variable to hold the Sender and Reciever User Objects
  User receiver;
  User sender;
}
