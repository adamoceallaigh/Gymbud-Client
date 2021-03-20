// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class ConversationNotifier extends StateNotifier<Conversation> {
  ConversationNotifier() : super(Conversation());

  void createConversation(Conversation newConversation) {
    state = newConversation;
  }

  void readConversation() => state;

  void updateConversation(Conversation updatedConversation) {
    state = updatedConversation;
  }

  void deleteConversation(Conversation targetConversation) => {
        state = null,
      };
}
