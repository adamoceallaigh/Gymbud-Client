//Imports and Variable Declarations
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                child: Image.asset('Resources/Images/logoGymbud.png'),
              ),
              Text('Sign Into Your Account'),
              TextField(),
              TextField(),
              Container(
                margin: EdgeInsets.only(bottom: 20.0 , top: 20.0),
                child: RaisedButton(
                  child: Text('Login'), 
                  onPressed: null
                ),
              ),
              Text('Forgot Your Password ?')
            ],
          ),
        ));
  }
}
