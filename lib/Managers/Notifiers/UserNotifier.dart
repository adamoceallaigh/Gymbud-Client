// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());

  void createUser(User newUser) {
    state = newUser;
  }

  void readUser() => state;

  void updateUser(User updatedUser) {
    state = updatedUser;
  }

  void deleteUser(User targetUser) => {
        state = null,
      };
}
