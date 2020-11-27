import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
// import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<User> users = List<User>();

  void setupUsers() async {
    UserController userController = new UserController();
    userController.getUsers().then((user) => 
      setState((){
        users.addAll(user);
      })
    );
  }

  @override
  void initState() {
    super.initState();
    setupUsers();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Gymbud'),
            backgroundColor: HexColor("FEFEFE"),
          ),
          body: ListView.builder(
            itemBuilder: (context , index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(top:32.0 , bottom: 32.0 , left:16.0 , right:16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text(
                        users[index].name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        users[index].userName,
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: users.length,
          )
        );
      }
    }