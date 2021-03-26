// Imports

// Library Imports

// Page Imports
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';

abstract class AppState {
  const AppState();
}

class AppInitial extends AppState {
  const AppInitial();
}

class AppLoading extends AppState {
  const AppLoading();
}

class AppLoaded extends AppState {
  // Initialize app user across all pages
  final User user;
  final String url;
  const AppLoaded({this.user, this.url});
}

class AppController extends StateNotifier<AppState> {
  final InitialUserController _initialUserController;
  AppController(this._initialUserController) : super(AppInitial());

  void setUpApp(BuildContext context) async {
    // All the different configurations for my urls
    String local_ios_url = "http://192.168.0.24:7000";
    String local_android_url = "http://10.0.2.2:7000";
    String heroku_url = "https://gymbud.herokuapp.com";
    String url_in_use;

    // Whether to use local server or not
    bool production = false;

    // Initial Loading state
    state = AppLoading();

    // Returning appUser to be used across all pages
    await _initialUserController.setUpApp();

    // Handle the url base link for all network requests
    if (production)
      url_in_use = heroku_url;
    else {
      if (Theme.of(context).platform == TargetPlatform.iOS)
        url_in_use = local_ios_url;
      else
        url_in_use = local_android_url;
    }

    // Changing state to loaded
    state = AppLoaded(url: url_in_use);
  }
}

class InitialUserController {
  InitialUserController();

  Future<bool> setUpApp() {
    bool isActive = false;
    return Future.delayed(Duration(seconds: 5), () {
      // Setting up a new appUser to be used across the app
      isActive = true;
      return isActive;
    });
  }
}
