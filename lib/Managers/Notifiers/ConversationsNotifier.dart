// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class ConversationsNotifier extends StateNotifier<List<Conversation>> {
  ConversationsNotifier() : super([]);

  void addConversations(List<Conversation> conversations) => {
        state = conversations,
      };

  void createConversation(Conversation conversation) => {
        state = [...state, conversation]
      };

  void readConversations() => state;

  void updateConversation(Conversation updatedConversation) => {
        state = [
          for (final conversation in state)
            if (conversation.id == updatedConversation.id)
              updatedConversation
            else
              conversation
        ]
      };

  void deleteConversation(Conversation targetConversation) => {
        state = state
            .where((conversation) => conversation.id != targetConversation.id)
            .toList(),
      };
}
