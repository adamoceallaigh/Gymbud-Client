// Imports

// Library Imports
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Infrastructure/Models/Conversation.dart';
import 'package:Client/Infrastructure/Models/Message.dart';
import 'package:Client/Infrastructure/Models/User.dart';

// Templaet to make a single message view page
class SingleMessageView extends HookWidget {
  // Passing our conversation over from the messages view page
  final Conversation conversation;

  // Instantiating the Single Message View Page
  SingleMessageView({this.conversation});

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
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager =
        GeneralHelperMethodManager(user: logged_in_user);

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
                backgroundImage: logged_in_user?.profileUrl != null
                    ? new NetworkImage(logged_in_user.profileUrl)
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
                message: conversation?.messages[index],
                user: logged_in_user,
              );
            },
            itemCount: conversation?.messages?.length,
          ),
        )),

        // Widget to make the bottom text input bar
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Icon(
                    Icons.mic,
                    color: HexColor("EB9661"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20 * .75),
                      decoration: BoxDecoration(
                        color: HexColor("EB9661").withOpacity(.09),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_alt_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    ));
  }

  Future<void> _initPusher() async {
    Channel _channel = new Channel();
    try {
      await Pusher.init('b7513c22bbecf883d9a7', PusherOptions(cluster: 'eu'));
    } catch (e) {
      print(e);
    }

    // Connect
    Pusher.connect(onConnectionStateChange: (val) {
      print(val.currentState);
    }, onError: (err) {
      print(err.message);
    });

    // Subscribe
    _channel = await Pusher.subscribe('messages');

    // Bind
    _channel.bind('newMessage', (onEvent) {
      // setState(() {
      //   widget?.conversation.messages
      // });
    });
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
