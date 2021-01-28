import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:flutter/material.dart';

class SessionDetails extends StatelessWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  SessionDetails({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
            title: Image.asset(
              "Resources/Images/logoGymbud.png",
              height: 100.0,
              width: 100.0
            ),
            backgroundColor: HexColor("FEFEFE"),
          ),
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
                Navigator.push(
                  context , 
                  MaterialPageRoute(builder: (context) => BasicSignUp(user:newUser)),
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