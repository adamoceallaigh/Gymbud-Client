// Imports

// Library Imports
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';

// Template for Home Screen
class HomeScreen extends HookWidget {
  /*
    Setting up variables for this page
  */

  // Variable to hold box shadow on boxes
  final List<BoxShadow> shadowList = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 30,
      offset: Offset(10.0, 10.0),
    )
  ];

  // // Logic functions

  // UI Functions

  // @override
  // void initState() {
  //   super.initState();
  //   getUserLoggedInActivites();
  // }

  @override
  Widget build(BuildContext context) {
    // Obtaining the drawer changer notifier provider for use here
    final drawer_changer = useProvider(drawer_change_provider);

    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    //Simple function to loop and return iterator for use
    getIterator() {
      for (var activity in logged_in_user.activities) {
        return activity;
      }
    }

    // Allows the container to scale and move as happens
    return IgnorePointer(
      ignoring: drawer_changer.isDrawerOpen,
      child: SingleChildScrollView(
        physics: drawer_changer.isDrawerOpen
            ? NeverScrollableScrollPhysics()
            : ScrollPhysics(),
        child: AnimatedContainer(
          height: logged_in_user.activities?.length * 830.0,
          transform: Matrix4.translationValues(
              drawer_changer.xOffset, drawer_changer.yOffset, 0)
            ..scale(drawer_changer.scaleFactor),
          duration: Duration(
            milliseconds: 250,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius:
                BorderRadius.circular(drawer_changer.isDrawerOpen ? 40 : 0),
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
                    drawer_changer.isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => {},
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () => {drawer_changer.slideOutDrawer()},
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
                      backgroundImage: logged_in_user?.profileUrl != null
                          ? new NetworkImage(logged_in_user.profileUrl)
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
                  children: logged_in_user.activities?.map((activity) {
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
                              height: 142,
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        activity?.activityType,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        activity?.activityName,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(activity?.time),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(activity?.date),
                                    ],
                                  ),

                                  // Adding Expanded here gave me a height to the row down below or else flutter gets messed up
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Stack(
                                            children:
                                                GeneralHelperMethodManager(
                                              logged_in_user: logged_in_user,
                                              index: logged_in_user.activities
                                                  .indexOf(
                                                getIterator(),
                                              ),
                                            ).getAttendeeCircles(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Text(
                                                  '${activity.participants[0].username} and others',
                                                  style:
                                                      GoogleFonts.meriendaOne(
                                                    color: HexColor("4B4848"),
                                                    fontSize: 15,
                                                    letterSpacing: -1.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
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
              })?.toList()),
            ],
          ),
        ),
      ),
    );
  }
}
