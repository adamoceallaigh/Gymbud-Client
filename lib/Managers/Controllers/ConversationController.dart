// Imports

// Library Imports
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
    List<Conversation> conversations;
    Response response = await dio.get('${this.url_in_use}');
    if (response.statusCode == 200) {
      var conversationsJSON = response.data;
      for (var userJSON in conversationsJSON) {
        conversations.add(Conversation.fromJSON(userJSON));
        return conversations;
      }
    }

    return null;
  }
}
