// Imports

//____General Imports______
import 'package:Client/Presentation/General_Pages/Splashscreen.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ___Page Imports________
import 'package:Client/Presentation/General_Pages/Onboarding_Screen.dart';

// Main Method
void main() async {
  // Running the main App
  runApp(ProviderScope(child: MyApp()));
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
        '/Login': (context) => Login(),
      },
    );
  }
}
