// Imports

//____General Imports______
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// ___Page Imports________
// import 'package:Client/pages/home.dart';
// import 'package:Client/pages/login.dart';
// import 'package:Client/pages/signup.dart';
// import 'package:Client/pages/loading.dart';
import 'package:Client/pages/onboardingScreen.dart';
import 'package:Client/pages/splashscreen.dart';

// Setting up routes and paths for the flutter app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/OnBoarding': (context) => OnBoarding(),
          // '/login': (context) => Login(),
          // '/signup': (context) => SignUp(),
          // '/Home': (context) => Home(),
        });
  }
}
