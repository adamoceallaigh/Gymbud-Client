// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Page Imports
import 'package:Client/Managers/Providers/DrawerChangeProvider.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/pages/ProfilePage.dart';
import 'package:Client/pages/FavouritesView.dart';
import 'package:Client/pages/GymbudPlusView.dart';
import 'package:Client/pages/MessagesView.dart';
import 'package:Client/pages/BudsView.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/CalendarView.dart';

// Template for the Drawer Screen
class DrawerScreen extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  DrawerScreen({Key key, @required this.user}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  /*
    Setting up our variables for this page
  */

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

  _checkWhereToNavigateByNavBarItemClick(
      String identifier, BuildContext context) {
    dynamic page = "";
    switch (identifier) {
      case "Profile":
        page = ProfilePage(user: widget?.user);
        break;
      case "Buds":
        page = BudsView(user: widget?.user);
        break;
      case "Calendar":
        page = CalendarView(
          user: widget?.user,
        );
        break;
      case "Messages":
        page = MessagesView(user: widget?.user);
        break;
      case "Favourites":
        page = FavouritesView(user: widget?.user);
        break;
      case "Gymbud Plus":
        page = GymbudPlusView(user: widget?.user);
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("EB9661"),
      padding: EdgeInsets.only(top: 40, left: 10, bottom: 85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Widget to make the top part of the drawer
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget?.user?.profileUrl != null
                            ? new NetworkImage(widget.user.profileUrl)
                            : null,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget?.user?.name != null
                              ? Text(
                                  widget?.user?.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  child: Text(
                                      "There was a problem gathering your info. Try log in again"),
                                ),
                          Text(
                            'Active Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("eeeeee"),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Consumer<DrawerChanger>(
                      builder: (context, drawerChanger, child) =>
                          GestureDetector(
                        onTap: () => {drawerChanger.resetDrawer()},
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                )
              ],
            ),
          ),

          // Widget to make the middle part of the drawer

          Column(
              children: drawerItems.map((element) {
            return GestureDetector(
              onTap: () => {
                _checkWhereToNavigateByNavBarItemClick(
                    element["title"], context),
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: element["type"] == null
                        ? Icon(
                            element["icon"],
                            color: Colors.white,
                            size: 30,
                          )
                        : element["icon"],
                  ),
                  Text(
                    element["title"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            );
          }).toList()),

          // Widget to make the footer of the drawer

          SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
