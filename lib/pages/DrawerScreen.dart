// Imports

// Library Imports
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Helper_Widgets/HexColor.dart';

// Template for the Drawer Screen
class DrawerScreen extends StatefulWidget {
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

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("EB9661"),
      padding: EdgeInsets.only(top: 40, left: 10, bottom: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Widget to make the top part of the drawer
          SafeArea(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adam O\' Ceallaigh',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Active Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: HexColor("eeeeee"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          // Widget to make the middle part of the drawer

          Column(
              children: drawerItems.map((element) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    element["icon"],
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  element["title"],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
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
