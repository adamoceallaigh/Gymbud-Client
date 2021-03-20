// // Imports

// // Library Imports
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Presentation/General_Pages/Calendar_View.dart';
import 'package:Client/Presentation/General_Pages/Favourites_View.dart';
import 'package:Client/Presentation/General_Pages/Gymbud_Plus_View.dart';
import 'package:Client/Presentation/Message_Management/Read_Message_Management/Read_Messages_View.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Profile_Page.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_Users_Buds_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// // Page Imports

class GeneralHelperMethodManager {
  final User user;
  final int index;
  GeneralHelperMethodManager({this.user, this.index});

  List<Widget> getAttendeeCircles() {
    List<Widget> widgetList = [];
    double right = 0;
    if (this.user.activities[index].participants.length == 1)
      right = 0;
    else
      right = -18;
    for (var user in this.user.activities[index].participants) {
      right += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
          bottom: 0,
          right: right,
        ),
      );
      if (this.user.activities[index].participants.indexOf(user) > 2) {
        break;
      }
    }
    return widgetList;
  }

  // Variable to hold all my drawerItems
  List<Map> drawerItems = [
    {
      'icon': Icons.person,
      'title': 'Profile',
    },
    {
      'icon': SvgPicture.asset(
        "Resources/Images/Buds_Icon.svg",
        height: 30,
      ),
      'title': 'Buds',
      'type': 'SVG'
    },
    {
      'icon': SvgPicture.asset(
        "Resources/Images/Calendar_Icon.svg",
        height: 30,
      ),
      'title': 'Calendar',
      'type': 'SVG'
    },
    {
      'icon': Icons.mail,
      'title': 'Messages',
    },
    {
      'icon': Icons.favorite,
      'title': 'Favourites',
    },
    {
      'icon': Icons.add,
      'title': 'Gymbud Plus',
    },
  ];

  // Logic Functions

  checkWhereToNavigateByNavBarItemClick(
      String identifier, BuildContext context) {
    dynamic page = "";
    switch (identifier) {
      case "Profile":
        page = ProfilePage();
        break;
      case "Buds":
        page = BudsView();
        break;
      case "Calendar":
        page = CalendarView();
        break;
      case "Messages":
        page = MessagesView();
        break;
      case "Favourites":
        page = FavouritesView();
        break;
      case "Gymbud Plus":
        page = GymbudPlusView();
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Retrieve Body
  getProfilePageBody(User logged_in_user, BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 10),
        child: Column(
          children: [
            getTopButtonsBar(context),
            getFollowersAndPicSection(logged_in_user),
            getNameAndLocation(logged_in_user),
            logged_in_user != null ? Container() : getFollowAndMessageBtns(),
            getProfileDetailsSection(logged_in_user),
          ],
        ),
      ),
    );
  }

  // Get Top Buttons Bar
  getTopButtonsBar(BuildContext context) {
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         UpdateProfilePage(user: logged_in_user),
                  //   ),
                  // )
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
  getFollowersAndPicSection(User logged_in_user) {
    // Widget for second Row with Picture
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  logged_in_user?.buds != null
                      ? '${logged_in_user?.buds?.length}K'
                      : "4356K",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "followers".toUpperCase(),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: logged_in_user?.profileUrl != null
                  ? new NetworkImage(logged_in_user.profileUrl)
                  : null,
              radius: 50,
            ),
            Column(
              children: [
                Text(
                  logged_in_user?.activities != null
                      ? '${logged_in_user?.activities?.length}'
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
  getNameAndLocation(User logged_in_user) {
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
                      logged_in_user?.name != null
                          ? logged_in_user?.name
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

  getProfileDetailsSection(User logged_in_user) {
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
            Text(logged_in_user?.username != null
                ? logged_in_user?.username
                : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.mail),
            ),
            Text(
                logged_in_user?.email != null ? logged_in_user?.email : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.calendar_today),
            ),
            Text(logged_in_user?.dob != null ? logged_in_user?.dob : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                  "Resources/Images/${checkGender(logged_in_user)}.svg"),
            ),
            Text(logged_in_user?.gender != null
                ? logged_in_user?.gender
                : "Well"),
          ],
        ),
      ],
    );
  }

  checkGender(User logged_in_user) {
    logged_in_user.gender = logged_in_user.gender.replaceAll(" ", "_");
    if (logged_in_user.gender == null)
      logged_in_user.gender = "Prefer Not To Say";
    switch (logged_in_user.gender) {
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
}
