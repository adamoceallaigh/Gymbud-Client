// Imports

// Library Imports
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
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

    final content_controller = useTextEditingController();

    // Obtainning the current conversation
    final current_conversation =
        useProvider(conversation_notifier_provider.state);

    _initPusher(context, logged_in_user, current_conversation);

    sendMessage(String value) async {
      try {
        // Get value first
        value = value ??
            Exception(
                "There was an error sending your message, please try again");
        var sender = Sender(
            senderId: logged_in_user.id, senderName: logged_in_user.name);
        var newMessage = Message(content: value, sender: sender);
        await context
            .read(conversations_provider)
            .createMessage(newMessage, current_conversation);
      } catch (e) {
        print(e);
      }
    }

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
                  message: current_conversation?.messages[index],
                  user: logged_in_user,
                );
              },
              itemCount: current_conversation?.messages?.length,
            ),
          ),
        ),

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
                              controller: content_controller,
                              onSubmitted: (value) => {
                                sendMessage(value),
                                content_controller.clear()
                              },
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

  Future<void> _initPusher(BuildContext context, User logged_in_user,
      Conversation current_conversation) async {
    Channel _channel = new Channel();
    try {
      await Pusher.init('9b49b4db0306d14a2271', PusherOptions(cluster: 'eu'));
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
    _channel.bind(
      'newMessage',
      (onEvent) async {
        print(onEvent.data);
        try {
          // Result from logging in user could either be a error or boolean saying true
          dynamic user_updated = await context
              .read(user_provider)
              .readSingleUserByID(logged_in_user);

          dynamic updated_conversation = await context
              .read(conversations_provider)
              .readConversationById(current_conversation);

          // Checking if the result is a error
          if (user_updated.runtimeType == InformationPopUp) {
            if (user_updated.message != null) {
              // Displaying error in pop up by setting the state

            }
          } else {
            // Navigating to the Home page if user logged in is returned
            if (user_updated.username != null) {
              await context
                  .read(conversation_notifier_provider)
                  .updateConversation(updated_conversation);
              await context
                  .read(user_notifier_provider)
                  .updateUser(user_updated);
            }
          }
        } catch (e) {
          print(e);
        }
      },
    );
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
