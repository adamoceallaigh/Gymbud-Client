// Imports

//____General Imports______
import 'package:Client/Helpers/HexColor.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//____Helper Widget Imports_________

//_______Page Imports_______

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Overriding the initiliazation state to be able to set up a timer once this
  //page has been initialized which will run and then move to the onboarding screen
  // When finished
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 10),
        // This anonymous function is responsible for moving to next page
        () => {Navigator.pushReplacementNamed(context, '/OnBoarding')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Image.asset('Resources/Images/logoGymbud.png'),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SpinKitThreeBounce(color: HexColor("2E2B2B"))])
        ],
      ),
    );
  }
}
