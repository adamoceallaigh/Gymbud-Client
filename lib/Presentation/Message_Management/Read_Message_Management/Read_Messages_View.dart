// Imports

// Library Imports
import 'package:Client/Config/configVariables.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/Message_Management/Read_Message_Management/Read_Single_Message_View.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Profile_Page.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_Users_Buds_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';

class MessagesView extends HookWidget {
  // Variable to hold box shadow on boxes
  final List<BoxShadow> shadowList = [
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
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

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
          if (logged_in_user.conversations.length > 0)
            Container(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: logged_in_user.conversations.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            context
                                .read(temp_user_notifier_provider)
                                .createTempUser(
                                    GeneralVariableStore.fakeUsers[index]),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            )
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // child: Image.network(
                            //   GeneralVariableStore.fakeUsers[index].profileUrl,
                            //   height: 70,
                            //   width: 70,
                            //   fit: BoxFit.cover,
                            // ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                GeneralVariableStore
                                    .fakeUsers[index].profileUrl,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            GeneralVariableStore.fakeUsers[index].username,
                            style: GoogleFonts.delius(
                              color: HexColor("2E2B2B"),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
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
            children: logged_in_user?.conversations?.length > 0
                ? logged_in_user.conversations.map((conversation) {
                    return conversation?.sender != null
                        ? GestureDetector(
                            onTap: () => {
                              context
                                  .read(conversation_notifier_provider)
                                  .createConversation(conversation),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleMessageView(),
                                ),
                              )
                            },
                            child: Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
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
                                          backgroundImage: conversation
                                                      ?.sender?.profileUrl !=
                                                  null
                                              ? NetworkImage(conversation
                                                  ?.sender?.profileUrl)
                                              : NetworkImage(
                                                  logged_in_user.profileUrl),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 20,
                                                  right: 10),
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
                                                        conversation?.messages[
                                                                    conversation
                                                                            .messages
                                                                            .length -
                                                                        1] !=
                                                                null
                                                            ? conversation
                                                                ?.messages[conversation
                                                                        .messages
                                                                        .length -
                                                                    1]
                                                                .sender
                                                                .senderName
                                                            : "",
                                                        style:
                                                            GoogleFonts.delius(
                                                          color: HexColor(
                                                              "2E2B2B"),
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                          conversation?.messages[
                                                                      conversation
                                                                              .messages
                                                                              .length -
                                                                          1] !=
                                                                  null
                                                              ? conversation
                                                                  ?.messages[conversation
                                                                          .messages
                                                                          .length -
                                                                      1]
                                                                  .content
                                                              : "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .delius(
                                                            color: HexColor(
                                                                "2E2B2B"),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 18,
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
                                                            ?.messages[
                                                                conversation
                                                                        .messages
                                                                        .length -
                                                                    1]
                                                            .createdAt
                                                            .split("T")[1]
                                                            .split(".")[0],
                                                        style:
                                                            GoogleFonts.delius(
                                                          color: HexColor(
                                                              "2E2B2B"),
                                                          fontWeight:
                                                              FontWeight.w500,
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
                        : SizedBox(
                            height: 40,
                          );
                  }).toList()
                : [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "You have signed up for no activities \nthus no messages yet. \n\nClick below to get started.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.delius(
                        color: HexColor("2E2B2B"),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createContinueToBasicDetailsPageBtn(context)
                  ].toList(),
          ),
        ],
      ),
    ));
  }

  // Create the button to navigate to the basic details page
  Widget createContinueToBasicDetailsPageBtn(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: StyleVariableStore.orange_gymbud_btn,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BudsView(),
            ),
          );
        },
        child: Text(
          "Find Some Buds",
          style: GoogleFonts.delius(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
