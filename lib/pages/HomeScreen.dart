// Imports

// Library Imports
import 'package:Client/Models/Activity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Page Imports
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/Models/Providers/DrawerChangeProvider.dart';

// Template for Home Screen
class HomeScreen extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Setting up variables for this page 
  */

  List<Activity> userLoggedInActivities = [];

  // Variable to hold box shadow on boxes
  List<BoxShadow> shadowList = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 30,
      offset: Offset(10.0, 10.0),
    )
  ];

  // Logic functions

  getUserLoggedInActivites() async {
    for (var activity in widget?.user?.activities) {
      setState(() {
        userLoggedInActivities.add(Activity.fromJSON(activity));
      });
    }
  }

  List<Widget> getAttendeeCircles(int index) {
    List<Widget> widgetList = [];
    double left = 0;
    if (widget.user.activities[index]["Participants"].length == 1)
      left = 0;
    else
      left = -18;
    for (var user in widget.user.activities[index]["Participants"]) {
      left += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user["Profile_Url"]),
          ),
          left: left,
        ),
      );
    }
    widgetList.add(Container());
    return widgetList;
  }

  // Simple function to loop and return iterator for use
  getIterator() {
    for (var activity in userLoggedInActivities) {
      return activity;
    }
  }

  // UI Functions

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInActivites();
  }

  @override
  Widget build(BuildContext context) {
    // Allows the container to scale and move as happens
    return Consumer<DrawerChanger>(
      builder: (context, drawerChanger, child) => IgnorePointer(
        ignoring: drawerChanger.isDrawerOpen,
        child: SingleChildScrollView(
          physics: drawerChanger.isDrawerOpen
              ? NeverScrollableScrollPhysics()
              : ScrollPhysics(),
          child: AnimatedContainer(
            height: 1000,
            transform: Matrix4.translationValues(
                drawerChanger.xOffset, drawerChanger.yOffset, 0)
              ..scale(drawerChanger.scaleFactor),
            duration: Duration(
              milliseconds: 250,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  BorderRadius.circular(drawerChanger.isDrawerOpen ? 40 : 0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),

                // Widget to make the appBar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Checks if the drawer is open to show the drawer or not
                      drawerChanger.isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => {
                                setState(
                                  () => {
                                    // xOffset = 0,
                                    // yOffset = 0,
                                    // scaleFactor = 1,
                                    // isDrawerOpen = false,
                                  },
                                )
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () => {drawerChanger.slideOutDrawer()},
                            ),

                      // Making the Stack Logo on top of container
                      Container(
                        width: 100,
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: shadowList,
                                    ),
                                    // margin: EdgeInsets.only(top: 10),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        "Resources/Images/Gymbud_Logo.svg",
                                        height: 60,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: widget?.user?.profileUrl != null
                            ? new NetworkImage(widget.user.profileUrl)
                            : null,
                        // backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                ),

                // Widget to make the search bar row
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      Text('Search for a bud here...'),
                      Icon(Icons.settings),
                    ],
                  ),
                ),

                // Widget to make the horizontal scroll view
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 5, left: 20),
                      child: Text(
                        "Recommended Users".toUpperCase(),
                        style: GoogleFonts.delius(
                          color: HexColor("EB9661"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                "Resources/Images/GymWeights.svg",
                                height: 50,
                                width: 50,
                                color: Colors.grey[700],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10),
                              child: Text("GymWeights"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, bottom: 5, left: 20),
                      child: Text(
                        "Past Activities".toUpperCase(),
                        style: GoogleFonts.delius(
                          color: HexColor("EB9661"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                // Widget to make the Cards
                Column(
                    children: userLoggedInActivities.map((activity) {
                  return activity?.activityImageUrl != null
                      ? Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: HexColor("EB9661"),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: shadowList,
                                  ),
                                  margin: EdgeInsets.only(left: 150),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: Image.network(
                                    activity != null
                                        ? activity?.activityImageUrl
                                        : "",
                                    height: 150,
                                    width: 120,
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 130,
                                width: 130,
                                margin: EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  right: 25,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          activity?.activityType,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      activity?.activityName,
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(activity?.activityDescription),
                                    Text(activity?.date),
                                    Text(activity?.time),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 2),
                                        height: 70,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Stack(
                                                  children: getAttendeeCircles(
                                                      userLoggedInActivities
                                                          .indexOf(
                                                              getIterator()))),
                                            ),
                                            Text(
                                              '${activity.participants.length.toString()} / 6',
                                              style: GoogleFonts.meriendaOne(
                                                color: HexColor("#000000"),
                                                fontSize: 18,
                                                letterSpacing: -1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1599058917212-d750089bc07e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1949&q=80")),
                          ],
                        );
                }).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
