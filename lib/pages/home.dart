//Imports and Variable Declarations
// import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CalendarView.dart';
import 'HomeView.dart';
import 'MatchView.dart';
import 'ProfilePage.dart';

///Setting my Page up as a Stateful Widget
///so I can change the state of the list of users

class Home extends StatefulWidget {
  final User user;

  // We are going to instantiate a NewTripLocation with a required Trip instance
  // This is the way we are going to save the values across the pages
  Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// This function retrieves all users from the
  /// UserController and passes it to a state variable
  /// So you can make a ListView Builder out of it below
  ///
  // List<User> users = List<User>();
  int _currentIndex = 0;
  List<Widget> _tabPages = [];
  Widget filterWidget;

  // Using Initiliazation method to set the state once with the list of users
  @override
  void initState() {
    super.initState();
    // setupUsers();
    this._tabPages = [HomeView(), MatchView(user: widget.user), CalendarView()];
  }

  // final _tabPages = [HomeView(), MatchView(), CalendarView()];

  void onTabTapped(int index) {
    setState(() => {_currentIndex = index});
  }

  List<Widget> getTopBarActions() {
    List<Widget> actionsList = new List<Widget>();
    actionsList = [
      GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(user: widget.user)),
          ),
        },
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: widget.user.profileUrl != null
              ? new NetworkImage(widget.user.profileUrl)
              : null,
          backgroundColor: Colors.transparent,
        ),
      ),
    ];
    return actionsList;
  }

  Widget getAppBar() {
    if (_currentIndex == 1) {
      return AppBar(
        title: GestureDetector(
          onTap: () => {
            print("Well"),
          },
          child: Container(
            margin: EdgeInsets.only(left: 4, right: 4),
            height: 40,
            decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              border: Border.all(
                width: 1.0,
                color: HexColor('#C4C4C4'),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FILTER BY",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: HexColor("#000000"),
                  ),
                ),
                SizedBox(width: 10),
                SvgPicture.asset("Resources/Images/arrowFilter.svg"),
              ],
            ),
          ),
        ),
        leading: Container(
          height: 120,
          padding: const EdgeInsets.all(0),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'Resources/Images/logoGymbud.png',
                fit: BoxFit.fill,
              ),
            ),
          ]),
        ),
        actions: getTopBarActions(),
        backgroundColor: HexColor("FEFEFE"),
      );
    }
    return AppBar(
      leading: Container(
        height: 120,
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'Resources/Images/logoGymbud.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
      actions: getTopBarActions(),
      // leading: Image.asset("Resources/Images/logoGymbud.png",
      // height: 100.0, width: 100.0),
      backgroundColor: HexColor("FEFEFE"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: _tabPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: HexColor("EB9661"),
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
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
