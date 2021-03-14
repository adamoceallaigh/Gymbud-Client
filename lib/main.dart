// Imports

//____General Imports______
import 'package:flutter/material.dart';

// ___Page Imports________
import 'package:Client/pages/onboardingScreen.dart';
import 'package:Client/pages/splashscreen.dart';

// Main Method
void main() {
  runApp(MyApp());
}

// Main Scaffolding for the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/OnBoarding': (context) => OnBoarding(),
        });
  }
}
