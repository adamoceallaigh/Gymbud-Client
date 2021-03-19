// Imports

// Library Imports
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// Page Imports
import 'package:Client/Models/User.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Pages/Activity_Management/Read_Activity_Management/Read_Activities_Match_View.dart';

// Template to make the Buds View Page
class BudsView extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  BudsView({Key key, this.user}) : super(key: key);

  @override
  _BudsViewState createState() => _BudsViewState();
}

// State to manage the template for this page
class _BudsViewState extends State<BudsView> {
  /*
    Setting up variables for this page
  */

  // Logic Functions

  // UI Functions

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

  // Logic Functions

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  child: Icon(Icons.arrow_back),
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

          // Widget to make the rows for the conversations
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Buds".toUpperCase(),
                  style: GoogleFonts.delius(
                    color: HexColor("EB9661"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Expanded(
                  child: Container(
                      height: 40,
                      color: HexColor("EB9661"),
                      child: ElevatedButton(
                        child: Text("Find Some Buds"),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchView(
                                      user: widget.user,
                                    )),
                          )
                        },
                      )),
                ),
              )
            ],
          )

          // Widget to make my conversations List
          // Row(
          //   children: ,
          // ),
        ],
      ),
    ));
  }
}
