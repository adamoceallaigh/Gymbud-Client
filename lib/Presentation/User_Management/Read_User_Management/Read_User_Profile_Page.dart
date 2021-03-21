// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Infrastructure/Models/User.dart';

class ProfilePage extends HookWidget {
  /*
    Setting up variables for this page
  */

  final User user;
  final User secondUser;
  ProfilePage({Key key, this.user, this.secondUser}) : super(key: key);

  /*
    Setting up variables for this page
  */

  // Logic Functions

  // UI Functions
  @override
  Widget build(BuildContext context) {
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager = GeneralHelperMethodManager(
        logged_in_user: logged_in_user, context: context);

    return Scaffold(
      body: generalHelperMethodManager.getProfilePageBody(),
    );
  }
}
