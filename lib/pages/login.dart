//Imports and Variable Declarations
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/pages/Home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final InformationPopUp infoPopUp;

  Login({this.infoPopUp});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _selectedPassword, _selectedUsername;

  void _setValues() async {
    UserController userController = new UserController();
    try {
      dynamic userValidated =
          await userController.loginUser(_selectedUsername, _selectedPassword);
      if (userValidated.runtimeType == InformationPopUp) {
        if (userValidated.message != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Login(infoPopUp: userValidated)),
          );
        }
      }
      if (userValidated.username != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(user: userValidated)),
        );
      }
    } catch (e) {
      print('caught error $e');
    }
  }

  List<Widget> _buildChildren() {
    var list = [
      Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: 180,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
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
        margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
        child:
            RaisedButton(child: Text('Login'), onPressed: () => {_setValues()}),
      ),
      Text('Forgot Your Password ?')
    ];

    if (widget.infoPopUp.message != null) {
      list.insert(
          0,
          Container(
            color: Colors.amberAccent,
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.error_outline),
                ),
                Expanded(child: Text(widget.infoPopUp.message)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => {
                    setState(() {
                      widget.infoPopUp.message = null;
                    })
                  },
                ),
              ],
            ),
          ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 580,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildChildren()),
        ),
      ),
    );
  }
}
