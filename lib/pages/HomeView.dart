import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  // List<User> users = List<User>();
  // HomeView({Key key, @required this.users}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<User> users = List<User>();

  void setupUsers() async {
    UserController userController = new UserController();
    userController.getUsers().then((user) => setState(() {
          users.addAll(user);
        }));
  }

  @override
  void initState() {
    super.initState();
    setupUsers();
    // this._tabPages = [
    //   HomeView(users: users),
    //   MatchView(),
    //   CalendarView()
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            users[index].name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              users[index].userName,
                              style: TextStyle(color: HexColor("EB9661")),
                            ),
                          ),
                          Text(
                            "Preferred Intensity: " +
                                users[index].preferredIntensity,
                            // style: TextStyle(
                            //   color: HexColor("EB9661")
                            // ),
                          ),
                          Text(
                            "Video / In Person: " +
                                users[index].videoOrInPerson,
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
                      Positioned(
                        top: -5,
                        right: 0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: users[index].profile_url != null
                              ? new NetworkImage(users[index].profile_url)
                              : null,
                          backgroundColor: Colors.transparent,
                        ),
                        // child: Container(

                        //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                        //   height: 100,
                        //   width: 70,
                        //   child: users[index].profile_url != null ? new Image.network(users[index].profile_url , fit: BoxFit.cover) :  null
                        // )
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: users.length,
          ),
        ),
      ],
    );
  }
}
