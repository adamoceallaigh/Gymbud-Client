// Imports

// Library Imports
import 'dart:collection';

import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Presentation/Activity_Management/Create_Activity_Management/Create_Activity_Onboarding.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  //
  CalendarController _calendarController;
  List filteredActivities = [];
  List<dynamic> _selectedActivities;
  List<dynamic> _activities;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  List<Activity> activities_dates;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedActivities = [];
    _activities = [];
    activities_dates = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the dates notifier
    final dates_notifier = context.read(dates_notifier_provider);

    // Get the video url
    final video_url =
        context.read(activity_notifier_provider.state).activityVideoUrl;

    // Get All the Users activities
    var logged_in_users_activities =
        context.read(user_notifier_provider.state).activities;
    print(logged_in_users_activities);

    var filterDates = Map<DateTime, List<dynamic>>();

    // _activities =
    //     logged_in_users_activities.map((activity) => activity.id).toList();
    // print(logged_in_users_activities);

    var allEvents = [];

    logged_in_users_activities.map((outerActivity) {
      var temp_activity_list = [];
      for (var tempActivity in logged_in_users_activities) {
        if (tempActivity.date != outerActivity.date) return;
        temp_activity_list.add(tempActivity.id);
      }
      allEvents.add(List<dynamic>.from(temp_activity_list));
    }).toList();

    for (var event in allEvents) {
      for (var activity in logged_in_users_activities) {
        filterDates[DateTime.parse('${activity.date} ${activity.time}')] =
            event;
      }
    }

    // _activities = List<dynamic>.from(logged_in_users_activities);
    // _activities.forEach((activity) =>
    //     filterDates[DateTime.parse('${activity.date} ${activity.time}')] =
    //         _activities);

    // // Get all the dates from the users_activities
    // for (var activity in logged_in_users_activities) {
    //   filteredActivities.add({
    //     DateTime.parse('${activity.date} ${activity.time}'):
    //         logged_in_users_activities
    //             .where((act) => act.date == activity.date)
    //             .toList()
    //   });
    // }

    // // print(filteredActivities);
    // var logged_in_users_activities_dates = Map();
    // filteredActivities.forEach((activity) {
    //   activity.forEach((key, value) {
    //     if (!logged_in_users_activities_dates.containsKey(key)) {
    //       logged_in_users_activities_dates[key] = [value];
    //     } else {
    //       logged_in_users_activities_dates[key].add(value);
    //     }
    //   });
    // });

    // logged_in_users_activities_dates =
    //     Map<DateTime, List<dynamic>>.from(logged_in_users_activities_dates);

    Container taskList(
        String title, String description, IconData iconImg, Color iconColor) {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Icon(
              iconImg,
              color: iconColor,
              size: 30,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    "http://localhost:3030/",
                    // videoUrl,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    List<Activity> getChildren() {
      List<Activity> allActivities = [];
      for (var event in _selectedActivities) {
        for (var activity in logged_in_users_activities) {
          if (event != activity.id) break;
          allActivities.add(activity);
        }
      }
      ;
      return allActivities;
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () => {
                        Navigator.pop(context),
                      },
                    ),
                  ),
                ],
              ),
              TableCalendar(
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: HexColor("EB9661"),
                  ),
                ),
                calendarController: _calendarController,
                // activitys: logged_in_users_activities_dates,
                events: filterDates,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, _) {
                  // context.read(dates_notifier_provider).setDates(activitys);
                  setState(() {
                    _selectedActivities = events;
                    // allEvents = events;
                    // if (_selectedActivities.isEmpty) {
                    //   activities_dates = [];
                    //   return;
                    // }
                    // // activities_dates = _selectedActivitys;
                    // _selectedActivities.forEach((activity) {
                    //   activity.forEach((value) {
                    //     activities_dates.add(value);
                    //   });
                    // });
                  });
                },
                calendarStyle: CalendarStyle(
                  todayColor: HexColor("EB9661"),
                  // contentDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.orange)),
                  selectedColor: HexColor("EB9661"),
                  weekendStyle: TextStyle(
                    color: HexColor("EB9661"),
                  ),
                ),
                initialSelectedDay: DateTime.now(),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: HexColor("#30384C"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: HexColor("#30384C"),
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: HexColor("#30384C"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  minHeight: 300,
                ),
                // height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: HexColor("EB9661"),
                ),
                child: Stack(
                  children: [
                    // context
                    //       .read(dates_notifier_provider)
                    //       .value
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getChildren().map((activity) {
                        return taskList(
                          activity?.activityName,
                          activity.activityDescription,
                          // video_url ?? "",
                          CupertinoIcons.check_mark_circled_solid,
                          Colors.white,
                        );
                      }).toList(),
                      // children: [
                      //   Padding(
                      //     padding: EdgeInsets.only(top: 50),
                      //     child: Text(
                      //       "Today",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 30,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   taskList(
                      //     "Gym workout",
                      //     "Video Url : http://localhost:3030//gjhgj5678hb39b29",
                      //     CupertinoIcons.check_mark_circled_solid,
                      //     Colors.white,
                      //   ),
                      //   taskList(
                      //     "Home Workout",
                      //     "Video Url : http://localhost:3030//gjhgj5678hb39b29",
                      //     CupertinoIcons.check_mark_circled_solid,
                      //     Colors.white,
                      //   ),
                      //   taskList(
                      //     "Outdoor Activity",
                      //     "Stroll In the Parks",
                      //     CupertinoIcons.check_mark_circled_solid,
                      //     Colors.white,
                      //   )
                      // ],
                    ),
                    Positioned(
                      bottom: 50,
                      // height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Container(),
                    ),
                    Positioned(
                      bottom: 110,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddActivityOnboarding(),
                            ),
                          ),
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Text(
                            "+",
                            style: GoogleFonts.delius(
                              color: HexColor("EB9661"),
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
