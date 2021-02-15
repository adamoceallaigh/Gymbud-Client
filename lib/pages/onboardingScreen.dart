//Imports and Variable Declarations
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/login.dart';
import 'package:flutter/material.dart';

import 'New_User/BasicSignUp.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final newUser = new User(null, null, null, null, null, null, null, null,
        null, null, null, null, [], [], [], [], []);
    final InformationPopUp infoPopUp = new InformationPopUp();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(infoPopUp: infoPopUp)),
                )
              },
            ),
            RaisedButton(
              child: Text('Sign Up'),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasicSignUp(user: newUser)),
                )
                // Navigator.pushReplacementNamed(context, '/signup')
              },
            ),
          ],
        ),
      ),
    );
  }
}
