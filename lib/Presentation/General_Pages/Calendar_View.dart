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

// ignore: must_be_immutable
class CalendarView extends HookWidget {
  //

  @override
  Widget build(BuildContext context) {
    List filteredActivities = [];
    List<dynamic> _selectedEvents = [];
    CalendarController _calendarController = CalendarController();
    DateTime _focusedDay = DateTime.now();
    DateTime _selectedDay;

    // Get the dates notifier
    final dates_notifier = useProvider(dates_notifier_provider);

    // Get All the Users activities
    final logged_in_users_activities =
        useProvider(user_notifier_provider.state).activities;

    // Get all the dates from the users_activities
    for (var activity in logged_in_users_activities) {
      filteredActivities.add({
        DateTime.parse('${activity.date} ${activity.time}'):
            logged_in_users_activities
                .where((act) => act.date == activity.date)
                .toList()
      });
    }

    print(filteredActivities);
    var logged_in_users_activities_dates = Map();
    filteredActivities.forEach((activity) {
      activity.forEach((key, value) {
        if (!logged_in_users_activities_dates.containsKey(key)) {
          logged_in_users_activities_dates[key] = [value];
        } else {
          logged_in_users_activities_dates[key].add(value);
        }
      });
    });

    logged_in_users_activities_dates =
        Map<DateTime, List<dynamic>>.from(logged_in_users_activities_dates);

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
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TableCalendar(
                calendarController: CalendarController(),
                events: logged_in_users_activities_dates,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, _) {
                  context.read(dates_notifier_provider).setDates(events);
                },
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
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: HexColor("EB9661"),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // children: context
                      //     .read(dates_notifier_provider)
                      //     .value
                      //     .map((activity) {
                      //   return taskList(
                      //     activity?.activityName,
                      //     activity.time,
                      //     CupertinoIcons.check_mark_circled_solid,
                      //     HexColor("00CF8D"),
                      //   );
                      // }).toList(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        taskList(
                          "Gym workout",
                          "Video Url : http://localhost:3030//gjhgj5678hb39b29",
                          CupertinoIcons.check_mark_circled_solid,
                          HexColor("#00CF8D"),
                        ),
                        taskList(
                          "Home Workout",
                          "Video Url : http://localhost:3030//gjhgj5678hb39b29",
                          CupertinoIcons.check_mark_circled_solid,
                          HexColor("#00CF8D"),
                        ),
                        taskList(
                          "Outdoor Activity",
                          "Stroll In the Parks",
                          CupertinoIcons.check_mark_circled_solid,
                          HexColor("#00CF8D"),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              HexColor("#30384C").withOpacity(0),
                              HexColor("#30384C"),
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddActivityOnboarding()),
                          ),
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: HexColor("#B038F1"),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 30,
                                )
                              ]),
                          child: Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
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
