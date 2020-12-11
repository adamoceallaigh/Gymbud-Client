//Imports and Variable Declarations
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('Resources/Images/logoGymbud.png')),
            RaisedButton(
              child: Text('Log in'),
              onPressed: () => {
                Navigator.pushReplacementNamed(context, '/login')
              },
            ),
            RaisedButton(
              child: Text('Sign Up'),
              onPressed: () => {
                Navigator.pushReplacementNamed(context, '/signup')
              },
            ),
          ],
        ),
      ),
    );
  }
}
