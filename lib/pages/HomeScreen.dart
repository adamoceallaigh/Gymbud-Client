// Imports

// Library Imports
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Page Imports
import 'package:Client/Helper_Widgets/HexColor.dart';

// Template for Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Setting up variables for this page 
  */

  // Variable to hold box shadow on boxes
  List<BoxShadow> shadowList = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 30,
      offset: Offset(10.0, 10.0),
      // offset: Offset(0, 10),
    )
  ];

  // Variables to enable drawer to be shown
  double xOffset = 0;
  double yOffset = 0;

  // Variables to allow the scaling down of the drawer
  double scaleFactor = 1;

  // Boolean to indicate whether drawer is open or closed
  bool isDrawerOpen = false;

  // Logic functions

  // UI Functions

  @override
  Widget build(BuildContext context) {
    // Allows the container to scale and move as happens
    return SingleChildScrollView(
      child: AnimatedContainer(
        height: 1000,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(
          milliseconds: 250,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
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
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => {
                            setState(
                              () => {
                                xOffset = 0,
                                yOffset = 0,
                                scaleFactor = 1,
                                isDrawerOpen = false,
                              },
                            )
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () => {
                            setState(
                              () => {
                                xOffset = 230,
                                yOffset = 150,
                                scaleFactor = 0.6,
                                isDrawerOpen = true,
                              },
                            )
                          },
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
                    radius: 20.0,
                    // backgroundImage: widget.user.profileUrl != null
                    //     ? new NetworkImage(widget.user.profileUrl)
                    //     : null,
                    backgroundColor: Colors.orange,
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
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
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
                        Text("GymWeights"),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Widget to make the Cards
            Container(
              height: 240,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: HexColor("EB9661"),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        Align(
                          child: SvgPicture.asset(
                            "Resources/Images/Male.svg",
                            height: 150,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 60, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowList,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
