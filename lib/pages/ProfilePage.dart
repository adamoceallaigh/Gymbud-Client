// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helper_Widgets/ButtonProducer.dart';
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Models/User.dart';

// Template for Profile Page
class ProfilePage extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  final User user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /*
    Setting up variables for this page
  */

  // Logic Functions

  // UI Functions
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getProfilePageBody());
  }

  // Retrieve Body
  getProfilePageBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 10),
        child: Column(
          children: [
            getTopButtonsBar(),
            getFollowersAndPicSection(),
            getNameAndLocation(),
            getFollowAndMessageBtns(),
          ],
        ),
      ),
    );
  }

  // Get Top Buttons Bar
  getTopButtonsBar() {
    return // Back button and top bar widget
        Column(
      children: [
        Row(
          children: [
            Icon(Icons.arrow_back),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  // Get Followers and Pic Section
  getFollowersAndPicSection() {
    // Widget for second Row with Picture
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "4356K",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "followers".toUpperCase(),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: widget?.user?.profileUrl != null
                  ? new NetworkImage(widget.user.profileUrl)
                  : null,
              radius: 50,
            ),
            Column(
              children: [
                Text(
                  "743",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Past Activites".toUpperCase(),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // Widget for third row with name and loaction
  getNameAndLocation() {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 135),
                    child: Text(
                      widget?.user?.name != null
                          ? widget?.user?.name
                          : "Sarah Geller".toUpperCase(),
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: HexColor("#BDBDBD"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "France",
                        style: TextStyle(
                          color: HexColor("#BDBDBD"),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  getFollowAndMessageBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 5,
              ),
              Text(
                "Follow".toUpperCase(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          style: ButtonProducer.getFollowGymbudBtn(),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () => {},
          child: Text(
            "Message".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          style: ButtonProducer.getMessageGymbudBtn(),
        )
      ],
    );
  }
}
