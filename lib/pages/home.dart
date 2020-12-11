//Imports and Variable Declarations
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

///Setting my Page up as a Stateful Widget 
///so I can change the state of the list of users

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = List<User>();

  /// This function retrieves all users from the 
  /// UserController and passes it to a state variable
  /// So you can make a ListView Builder out of it below
  void setupUsers() async {
    UserController userController = new UserController();
    userController.getUsers().then((user) => 
      setState((){
        users.addAll(user);
      })
    );
  }

  // Using Initiliazation method to set the state once with the list of users
  @override
  void initState() {
    super.initState();
    setupUsers();
  }

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
          body: Column(
            children: <Widget>[
              Card(
                child: Container(
                  color: Colors.white,
                  height: 50,
                  child: Center(
                    child: Text("Past Users / Sessions"),
                  ),
                ),
            ),
            Expanded(
              child: 
              ListView.builder(
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
                        Container(
                          margin: EdgeInsets.only(bottom:15.0),
                          child: Text(
                            users[index].userName,
                            style: TextStyle(
                              color: HexColor("EB9661")
                            ),
                          ),
                        ),
                        Text(
                          "Preferred Intensity: " + users[index].preferredIntensity,
                          // style: TextStyle(
                          //   color: HexColor("EB9661")
                          // ),
                        ),
                        Text(
                          "Video / In Person: " + users[index].videoOrInPerson,
                          // style: TextStyle(
                          //   color: HexColor("EB9661")
                          // ),
                        ),
                        Text(
                          "Fitness Level: " + users[index].fitnessLevel,
                          // style: TextStyle(
                          //   color: HexColor("EB9661")
                          // ),
                        ),
                        Text(
                          "Resources: " + users[index].resources.toString(),
                          // style: TextStyle(
                          //   color: HexColor("EB9661")
                          // ),
                        ),
                    ],
                    ),
                ),
              );
            },
            itemCount: users.length,
            ),
          ),
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: HexColor("EB9661"),
            currentIndex: 0, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "Resources/Images/House_Icon.png"
                ),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "Resources/Images/Buds_Icon.png"
                ),
                label:'Buds',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "Resources/Images/Calendar_Icon.png"
                ),
                label:'Calendar'
              )
            ],
          ),
        );
      }
    }