import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

// import 'home.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            // GestureDetector(
            //     onTap: () => {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => Home(user: widget.user)),
            //           ),
            //         },
            //     child: Icon(Icons.arrow_back))
          ],
          title: Text(
            "Profile",
            style: TextStyle(color: HexColor("#bdbdbd")),
          ),
          centerTitle: true,
          // backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.visible,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: widget.user.profileUrl != null
                            ? new NetworkImage(widget.user.profileUrl)
                            : null,
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        bottom: 0,
                        right: -12,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white)),
                            color: Color(0xFFF5F6F9),
                            child: Icon(Icons.camera_alt),
                            onPressed: () => {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.userName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.dob),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.gender),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.fitnessLevel),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.resources.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.preferredAgeRange),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.preferredDistanceRange),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.preferredIntensity),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.user.videoOrInPerson),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
