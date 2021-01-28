// Imports 

//____General Imports______
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// ___Page Imports________
import './Pages/home.dart';
import './Pages/login.dart';
import './Pages/signup.dart';
// import './Pages/loading.dart';
import './Pages/onboardingScreen.dart';
import './Pages/splashscreen.dart';

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
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/Home': (context) => Home(),
        }
    );
  }
}
