// Imports

// Library Imports
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Managers/Controllers/ActivityController.dart';
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:Client/Managers/Controllers/ConversationController.dart';
import 'package:Client/Managers/Controllers/ImageController.dart';
import 'package:Client/Managers/Controllers/UserController.dart';
import 'package:Client/Managers/Controllers/VideoController.dart';
import 'package:Client/Managers/Notifiers/ActivitiesNotifier.dart';
import 'package:Client/Managers/Notifiers/ActivityNotifier.dart';
import 'package:Client/Managers/Notifiers/ConversationNotifier.dart';
import 'package:Client/Managers/Notifiers/ConversationsNotifier.dart';
import 'package:Client/Managers/Notifiers/DatesNotifier.dart';
import 'package:Client/Managers/Notifiers/DrawerChangeProvider.dart';
import 'package:Client/Managers/Notifiers/ErrorMessageNotifier.dart';
import 'package:Client/Managers/Notifiers/ImageNotifier.dart';
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

// Drawer Change Notifier
final drawer_change_provider = ChangeNotifierProvider((ref) => DrawerChanger());

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

// Conversations Controller Configuration
final conversations_provider = Provider<ConversationController>(
  (ref) => ConversationController(
    ref.watch(app_notifier_provider.state),
  ),
);

// Conversation Notifier Provider
final conversation_notifier_provider = StateNotifierProvider(
  (ref) => ConversationNotifier(),
);

// Conversations Notifier Provider
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
final activities_notifier_provider = StateNotifierProvider(
  (ref) => ActivitiesNotifier(),
);

final activity_notifier_provider = StateNotifierProvider(
  (ref) => ActivityNotifier(),
);

// Image Controller Configuration
final image_provider = Provider<ImageController>(
  (ref) => ImageController(
    ref.watch(app_notifier_provider.state),
  ),
);

// Image Notifier Provider
final image_notifier_provider = ChangeNotifierProvider(
  (ref) => ImageNotifier(),
);

// Dates Notifier Provider
final dates_notifier_provider = ChangeNotifierProvider(
  (ref) => DatesNotifier(),
);

// Video Player controller
final video_provider = Provider<VideoController>(
  (ref) => VideoController(ref.watch(app_notifier_provider.state)),
);

// Error Message Notifier
final error_notifier = ChangeNotifierProvider(
  (ref) => ErrorNotifier(),
);
