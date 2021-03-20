// Imports

// Library Imports

// Page Imports

class Message {
  //Variable to hold the id of the message
  String id;

  // Variable to hold the content of the message
  String content;

  // Variable to hold the sender of the message
  Sender sender;

  // Variable to hold the timestamps
  String createdAt;
  String updatedAt;

  // Optional Named Constructor for Message
  Message({this.content, this.sender});

  // Constructor to pull json data values and make up a Message model
  Message.fromJSON(Map<String, dynamic> data) {
    this.id = data["_id"];
    this.content = data["Content"];
    this.sender = Sender.fromJSON(data["Sender"]);
    this.createdAt = data['createdAt'];
    this.updatedAt = data['updatedAt'];
  }

  // Constructor to push data values and make up a json Message object
  static Map<String, dynamic> toJson(Message message) => {
        '_id': message.id,
        'Content': message.content,
        'Sender': Sender.toJson(message.sender),
      };

  @override
  String toString() {
    return Message.toJson(this).toString();
  }
}

// Helper Class to allow me to turn my Clas into Json string
class Sender {
  // String variables needed
  String senderName;
  String senderId;

  // Optional Named Constructor for Sender
  Sender({this.senderName, this.senderId});

  // Constructor to pull json data values and make up a Message model
  Sender.fromJSON(Map<String, dynamic> data) {
    this.senderName = data["senderName"];
    this.senderId = data["senderId"];
  }

  static Map<String, String> toJson(Sender sender) => {
        'senderName': sender.senderName,
        'senderId': sender.senderId,
      };

  @override
  String toString() {
    return Sender.toJson(this).toString();
  }
}
