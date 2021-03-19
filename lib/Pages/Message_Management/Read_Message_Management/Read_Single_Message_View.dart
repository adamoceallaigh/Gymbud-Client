// Imports

// Library Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Models/Conversation.dart';
import 'package:Client/Models/Message.dart';
import 'package:Client/Models/User.dart';

// Templaet to make a single message view page
class SingleMessageView extends StatefulWidget {
  /*
    Setting up our variables
  */

  // Passing our conversation over from the messages view page
  final Conversation conversation;

  // Passing our user logged in over from messages view page
  final User user;

  // Instantiating the Single Message View Page
  SingleMessageView({this.conversation, this.user});

  @override
  _SingleMessageViewState createState() => _SingleMessageViewState();
}

class _SingleMessageViewState extends State<SingleMessageView> {
  /*
    Setting up our variables
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
        body: Column(
      children: [
        SizedBox(
          height: 50,
        ),

        // Widget to make the header
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

        // Widget to make the main text input body
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MessageTemplate(
                message: widget?.conversation?.messages[index],
                user: widget?.user,
              );
            },
            itemCount: widget?.conversation?.messages?.length,
          ),
        ))
      ],
    ));
  }
}

class MessageTemplate extends StatelessWidget {
  /*
    Setting up our variables
  */

  // Variables passed into template to style accordingly and get content
  final Message message;
  final User user;

  const MessageTemplate({Key key, this.message, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: user?.id == message?.sender?.senderId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 250),
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(
              horizontal: 20 * 0.75,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: user?.id == message?.sender?.senderId
                  ? HexColor("EB9661")
                  : Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message?.content != null ? message?.content : "",
              style: TextStyle(
                color: user?.id == message?.sender?.senderId
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
