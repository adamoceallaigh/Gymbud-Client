import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/User.dart';
import 'package:Client/pages/Session_Management/AddSessionOnboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  final User user;

  CalendarView({Key key, this.user}) : super(key: key);
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController _calendarController;
  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(
      color: HexColor("#0B2011"),
      fontWeight: fontWeight,
    );
  }

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

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                weekdayStyle: dayStyle(FontWeight.normal),
                weekendStyle: dayStyle(FontWeight.normal),
                selectedColor: HexColor("#30374B"),
                todayColor: HexColor("#30374B"),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: HexColor("#30384C"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                weekendStyle: TextStyle(
                  color: HexColor("#30384C"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                dowTextBuilder: (date, locale) {
                  return DateFormat.E(locale).format(date).substring(0, 1);
                },
              ),
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
              calendarController: _calendarController,
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
                color: HexColor("#30384C"),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Activity 1",
                        "Core Workout - Home Workout",
                        CupertinoIcons.check_mark_circled_solid,
                        HexColor("#00CF8D"),
                      ),
                      taskList(
                        "Task 2",
                        "Description of Task 2 to be updated here",
                        CupertinoIcons.check_mark_circled_solid,
                        HexColor("#00CF8D"),
                      ),
                      taskList(
                        "Task 3",
                        "Description of Task 3 to be updated here",
                        CupertinoIcons.check_mark_circled_solid,
                        HexColor("#00CF8D"),
                      ),
                      taskList(
                        "Task 4",
                        "Description of Task 4 to be updated here",
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
                              builder: (context) =>
                                  AddSessionOnboarding(user: widget.user)),
                        ),
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
    );
  }
}
