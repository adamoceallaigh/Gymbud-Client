//Imports and Variable Declarations
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _selectedPassword, 
  _selectedUsername; 

  void _setValues() async{ 
    UserController userController = new UserController();
    User newUser = new User.login(
        _selectedUsername, 
        _selectedPassword, 
    );
    bool userValidated = userController.loginUser(newUser);
    if(userValidated){
       Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(user: user)),
      ),
    }
  }

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
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Username:",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    TextField(
                      onSubmitted: (newText) {
                        _selectedUsername = newText;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Password:",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    TextField(
                      onSubmitted: (newText) {
                        _selectedPassword = newText;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0 , top: 20.0),
                child: RaisedButton(
                  child: Text('Login'), 
                  onPressed: () => {
                    _setValues()
                  }
                ),
              ),
              Text('Forgot Your Password ?')
            ],
          ),
        ));
  }
}
