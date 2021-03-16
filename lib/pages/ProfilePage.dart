// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helper_Widgets/ButtonProducer.dart';
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/UpdateProfilePage.dart';
import 'package:flutter_svg/svg.dart';

// Template for Profile Page
class ProfilePage extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  final User user;
  final User secondUser;
  ProfilePage({Key key, this.user, this.secondUser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /*
    Setting up variables for this page
  */

  // Logic Functions

  checkGender() {
    widget.user.gender = widget.user.gender.replaceAll(" ", "_");
    if (widget.user.gender == null) widget.user.gender = "Prefer Not To Say";
    switch (widget.user.gender) {
      case "Prefer_Not_To_Say":
      case "Non-Binary":
        return "All_Gender";
        break;
      case "Male":
      case "male":
        return "Male";
        break;
      case "Female":
      case "female":
        return "Female";
        break;
    }
  }

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
            widget?.user != null ? Container() : getFollowAndMessageBtns(),
            getProfileDetailsSection(),
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateProfilePage(user: widget?.user),
                    ),
                  )
                },
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Edit"),
                  ],
                ),
              ),
            ),
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
                  widget?.user?.buds != null
                      ? '${widget?.user?.buds?.length}K'
                      : "4356K",
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
                  widget?.user?.activities != null
                      ? '${widget?.user?.activities?.length}'
                      : "743",
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

  getProfileDetailsSection() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.person),
            ),
            Text(widget?.user?.username != null
                ? widget?.user?.username
                : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.mail),
            ),
            Text(widget?.user?.email != null ? widget?.user?.email : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.calendar_today),
            ),
            Text(widget?.user?.dob != null ? widget?.user?.dob : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset("Resources/Images/${checkGender()}.svg"),
            ),
            Text(widget?.user?.gender != null ? widget?.user?.gender : "Well"),
          ],
        ),
      ],
    );
  }
}
