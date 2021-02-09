//Imports and Variable Declarations
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';

import 'CalendarView.dart';
import 'HomeView.dart';
import 'MatchView.dart';

///Setting my Page up as a Stateful Widget
///so I can change the state of the list of users

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _tabPages = [
    HomeView(),
    MatchView(),
    CalendarView()
  ];

  void onTabTapped(int index) {
    setState(() => {
      _currentIndex = index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("Resources/Images/logoGymbud.png",
            height: 100.0, width: 100.0),
        backgroundColor: HexColor("FEFEFE"),
      ),
      body: _tabPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: HexColor("EB9661"),
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("Resources/Images/House_Icon.png"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("Resources/Images/Buds_Icon.png"),
            label: 'Buds',
          ),
          BottomNavigationBarItem(
              icon: Image.asset("Resources/Images/Calendar_Icon.png"),
              label: 'Calendar')
        ],
      ),
    );
  }
}
