// Imports

// Library Imports
import 'package:Client/Config/configVariables.dart';
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Infrastructure/Models/Activity.dart';
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Managers/Providers.dart';
// import 'package:Client/pages/ProfilePage.dart';

class SingleActivityView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Gtting the logged in user
    final logged_in_user = context.read(user_notifier_provider.state);

    final GeneralHelperMethodManager generalHelperMethodManager =
        GeneralHelperMethodManager(context: context);
    final activity_picked = context.read(activity_notifier_provider.state);

    List<Widget> getAttendeeCircles() {
      List<Widget> widgetList = [];
      for (var user in activity_picked.participants) {
        widgetList.add(
          CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
        );
      }
      widgetList.add(Container());
      return widgetList;
    }

    void addUserToActivity(activityId, userId, BuildContext context) async {
      // // Obtain all activities of the user and check before signing user up again
      // List<bool> checkSignedUpAlready = context
      //     .read(user_notifier_provider.state)
      //     .activities
      //     .map((activity) => activityId == activity?.id);

      // if (checkSignedUpAlready.contains(true)) {
      //   // TODO: Change the Message saying they've already signed up
      //   context.read(error_notifier).message =
      //       "Sorry, you've already signed up for this activity";
      //   return;

      // }

      // Checking to see if you are signing up for your own activity
      if (activity_picked.creator.id == logged_in_user.id) return;

      // Signing user up for the activity
      Activity isSignedUpActivity = await context
          .read(activities_provider)
          .addUserToActivity(activityId, userId);

      // Check to see if user was successful in signing up
      if (isSignedUpActivity.runtimeType == Activity) {
        // Add the user to the particpants in the selected activity
        activity_picked.participants.add(logged_in_user);

        // Take away the activity they signed up for from the activities
        context
            .read(activities_notifier_provider.state)
            .removeWhere((activity) => activity.id == isSignedUpActivity.id);

        // Update the user's logged in activities and add one created
        context
            .read(user_notifier_provider.state)
            .activities
            .add(isSignedUpActivity);

        // // Update the activities as a whole with the one we get back
        // context
        //     .read(activities_notifier_provider)
        //     .updateActivity(isSignedUpActivity);

        // Check to see if activity is full with people
        int isFull = await activity_picked.participants.length;
        if (isFull == 2) {
          // Make A Conversation between the two involved in the activity
          User receiver = activity_picked?.participants[0];
          String receiverId = activity_picked?.participants[0]?.id;

          Conversation newConversation = await context
              .read(conversations_provider)
              .createConversation(userId, receiverId, []);

          // Make the deafult sender object
          Sender newSender = Sender(
              senderId: activity_picked.creator.id,
              senderName: activity_picked.creator.name);

          // Add Default Message to the conversation as otherwise it won't show up on
          Message newMessage = Message(
            content:
                "Hey ${logged_in_user.name}, so the time is ${activity_picked.time} on ${activity_picked.date}, is this okay with you ?",
            sender: newSender,
          );

          //Send the newMessage so that it shows up on the page
          await context
              .read(conversations_provider)
              .createMessage(newMessage, newConversation);

          // Get the updated conversation with message attached
          Conversation updatedConversation = await context
              .read(conversations_provider)
              .readConversationById(newConversation);

          // Add new Conversation to logged in user
          await context
              .read(user_notifier_provider.state)
              .conversations
              .add(updatedConversation);

          // Checking to see if the activity type is home workout
          if (activity_picked.activityType != "Home_Workout") return;

          // Create a Video Link and attach it to the activity if it's a home or gym workout
          String newVideoUrl =
              await context.read(video_provider).createVideoLink();

          // Attaching it to the activity just made
          await context
              .read(activity_notifier_provider)
              .addVideoUrl(newVideoUrl);

          return;
        }

        // Get all the activities again and set them back up in state
        List<Activity> all_activities =
            await context.read(activities_provider).readActivities();
        context
            .read(activities_notifier_provider)
            .addActivities(all_activities);

        // Bring them back a page in the app
        Navigator.pop(context);
      }
    }

    Widget getSingleActivityBody() {
      return SingleChildScrollView(
        child: Container(
            height: 1280,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 470,
                  child: Hero(
                    tag: 'Activity ${activity_picked.hashCode}',
                    child: Image.network(
                      activity_picked.activityImageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  padding: EdgeInsets.all(6),
                  height: 800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Name",
                                  style: GoogleFonts.meriendaOne(
                                    color: HexColor("#000000"),
                                    fontSize: 18,
                                    letterSpacing: -1.5,
                                  ),
                                ),
                                Text(activity_picked.activityName),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Type Of Workout",
                                  style: GoogleFonts.meriendaOne(
                                    color: HexColor("#000000"),
                                    fontSize: 18,
                                    letterSpacing: -1.5,
                                  ),
                                ),
                                Text(activity_picked.activityType),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Looking To Workout With",
                                  style: GoogleFonts.meriendaOne(
                                    color: HexColor("#000000"),
                                    fontSize: 18,
                                    letterSpacing: -1.5,
                                  ),
                                ),
                                Text(activity_picked.activityGenderPreference),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text("Activity"),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  width: 250,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    // border: Border.all(
                                    //   color:
                                    //       HexColor('#eeeeee'), // set border color
                                    //   width: 1.0,
                                    // ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 4, right: 4, left: 4),
                                          width: 230,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F1BF60'),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  child:
                                                      Icon(Icons.date_range)),
//                                           SizedBox(width: 15.0),
                                              Expanded(
                                                child: Text(
                                                  "Activity Details",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          width: 230,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${activity_picked.date}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
//                                           SizedBox(width: 15.0),
                                              Expanded(
                                                child: Text(
                                                  '${activity_picked.time}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.meriendaOne(
                                        color: HexColor("#000000"),
                                        fontSize: 18,
                                        letterSpacing: -1.5,
                                      ),
                                      children: [
                                        TextSpan(text: 'Participants'),
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                '${activity_picked.participants.length}'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: getAttendeeCircles(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Resources",
                                  style: GoogleFonts.meriendaOne(
                                    color: HexColor("#000000"),
                                    fontSize: 18,
                                    letterSpacing: -1.5,
                                  ),
                                ),
                                Row(
                                  children: activity_picked.resources
                                      .map((resource) => Text(resource))
                                      .toList(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: StyleVariableStore.update_btn_style,
                            onPressed: () => {
                              addUserToActivity(
                                  activity_picked.id,
                                  context.read(user_notifier_provider.state).id,
                                  context),
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "I want to do this/I'm Available",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 70,
          padding: const EdgeInsets.all(0),
          child: Row(children: [
            Expanded(
              flex: 6,
              child: Image.asset(
                'Resources/Images/logoGymbud.png',
                fit: BoxFit.fill,
              ),
            ),
          ]),
        ),
        backgroundColor: HexColor("FEFEFE"),
      ),
      body: getSingleActivityBody(),
    );
  }
}

//https://www.youtube.com/watch?v=ZVznzY7EjuY
// Documentation for How I made the Zoom Clone
