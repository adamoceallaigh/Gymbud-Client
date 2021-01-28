import 'package:flutter/material.dart';
import 'package:Client/Models/User.dart';

import 'Upload_Photo.dart';

class BasicSignUp extends StatelessWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  BasicSignUp({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _userNameController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();

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
                    TextField(controller: _userNameController),
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
                    TextField(controller: _passwordController),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: RaisedButton(
                    child: Text('Login'),
                    onPressed: () => {
                          user.userName = _userNameController.text,
                          user.password = _passwordController.text,
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPhoto(user: user)),
                          ),
                        }),
              ),
              Text('Forgot Your Password ?')
            ],
          ),
        ));
  }
}
