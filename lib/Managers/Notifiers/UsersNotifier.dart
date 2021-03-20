// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]);

  void addUsers(List<User> users) => {
        state = users,
      };

  void createUser(User user) {
    state = [...state, user];
  }

  void readUsers() => state;

  void updateUser(User updatedUser) => {
        state = [
          for (final user in state)
            if (user.id == updatedUser.id) updatedUser else user
        ]
      };

  void deleteUser(User targetUser) => {
        state = state.where((user) => user.id != targetUser.id).toList(),
      };
}
