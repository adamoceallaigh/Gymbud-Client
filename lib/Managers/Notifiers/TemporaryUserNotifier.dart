// Imports

// Library Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/Models_Required.dart';

class TempUserNotifier extends StateNotifier<User> {
  TempUserNotifier() : super(User());

  void createTempUser(User newTempUser) {
    state = newTempUser;
  }

  // void setTempUsername(String tempUsername) {
  //   state.tempUsername = tempUsername;
  // }

  void readTempUser() => state;

  void updateTempUser(User updatedTempUser) {
    state = updatedTempUser;
  }

  void deleteTempUser(User targetTempUser) => {
        state = new User(),
      };
}
