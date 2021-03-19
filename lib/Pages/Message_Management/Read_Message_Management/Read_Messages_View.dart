// Imports

// Library Imports
import 'package:Client/Pages/Message_Management/Read_Message_Management/Read_Single_Message_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Models/Conversation.dart';
import 'package:Client/Models/User.dart';

// Template to make the Messages View Page
class MessagesView extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  MessagesView({Key key, this.user}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

// State to manage the template for this page
class _MessagesViewState extends State<MessagesView> {
  /*
    Setting up variables for this page
  */

  List<Conversation> userLoggedInConversations = [];

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

  getUserLoggedInMessages() async {
    for (var conversation in widget?.user?.conversations) {
      setState(() {
        userLoggedInConversations.add(conversation);
      });
    }
  }

  // UI Functions

  @override
  void initState() {
    super.initState();
    getUserLoggedInMessages();
  }

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
                  "Messages".toUpperCase(),
                  style: GoogleFonts.delius(
                    color: HexColor("EB9661"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),

          // Widget to make my conversations List
          Column(
            children: userLoggedInConversations.map((conversation) {
              return conversation?.sender != null
                  ? GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleMessageView(
                              conversation: conversation,
                              user: widget.user,
                            ),
                          ),
                        )
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                            ),
                            height: 140,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 20, right: 10),
                                        height: 100,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  conversation
                                                      ?.messages[conversation
                                                              .messages.length -
                                                          1]
                                                      .sender
                                                      .senderName,
                                                  style: GoogleFonts.delius(
                                                    color: HexColor("2E2B2B"),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    conversation
                                                        ?.messages[conversation
                                                                .messages
                                                                .length -
                                                            1]
                                                        .content,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.delius(
                                                      color: HexColor("2E2B2B"),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  conversation
                                                      ?.messages[conversation
                                                              .messages.length -
                                                          1]
                                                      .createdAt
                                                      .split("T")[1]
                                                      .split(".")[0],
                                                  style: GoogleFonts.delius(
                                                    color: HexColor("2E2B2B"),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                          // Text(conversation?.createdAt),
                          // Text("Well"),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Container(
                            child: Image.network(
                                "https://images.unsplash.com/photo-1599058917212-d750089bc07e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1949&q=80")),
                      ],
                    );
            }).toList(),
          ),
        ],
      ),
    ));
  }
}
