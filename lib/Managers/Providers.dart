// Imports

// Library Imports
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Managers/Controllers/ActivityController.dart';
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:Client/Managers/Controllers/ConversationController.dart';
import 'package:Client/Managers/Controllers/UserController.dart';
import 'package:Client/Managers/Notifiers/ActivitiesNotifier.dart';
import 'package:Client/Managers/Notifiers/ConversationsNotifier.dart';
import 'package:Client/Managers/Notifiers/UserNotifier.dart';
import 'package:Client/Managers/Notifiers/UsersNotifier.dart';

// Page Imports

// Overall App Provider Configuration
final app_provider = Provider<InitialUserController>(
  (ref) => InitialUserController(),
);

final app_notifier_provider = StateNotifierProvider(
  (ref) => AppController(
    ref.watch(app_provider),
  ),
);

// User Controller Configuration
final user_provider = Provider<UserController>(
  (ref) => UserController(
    ref.watch(app_notifier_provider.state),
  ),
);

// User Notifier Provider
final user_notifier_provider = StateNotifierProvider(
  (ref) => UserNotifier(),
);

// Users Notifier Provider
final users_notifier_provider = StateNotifierProvider(
  (ref) => UsersNotifier(),
);

// Conversation Controller Configuration
final conversations_provider = Provider<ConversationController>(
  (ref) => ConversationController(
    ref.watch(app_notifier_provider.state),
  ),
);

// Conversation Notifier Provider
final conversations_notifier_provider = StateNotifierProvider(
  (ref) => ConversationsNotifier(),
);

// Activitity Controller Configuration
final activities_provider = Provider<ActivityController>(
  (ref) => ActivityController(
    ref.watch(app_notifier_provider.state),
  ),
);

// Activities Notifier Provider
final activity_notifier_provider = StateNotifierProvider(
  (ref) => ActivitiesNotifier(),
);
