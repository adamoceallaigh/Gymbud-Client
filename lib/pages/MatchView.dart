import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/Session.dart';
import 'package:Client/pages/SingleSessionView.dart';
import 'package:flutter/material.dart';
import 'package:Client/Controllers/SessionController.dart';
//Importing TinderSwipeCard here allowing me to have same functionality easily as tinder cards
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchView extends StatefulWidget {
  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  List<Session> sessions = List<Session>();

  //Declaring my tinderCardController to be able to indicate when we swipe left or right easily
  CardController tinderCardController;

  void setupSessions() async {
    SessionController sessionController = new SessionController();
    sessionController.getSessions().then((session) => setState(() {
          sessions.addAll(session);
        }));
  }

  List<Widget> getAttendeeCircles(int index) {
    List<Widget> widgetList = new List<Widget>();
    double left = 0;
    if (sessions[index].capacity.length == 1)
      left = 0;
    else
      left = -18;
    for (var user in sessions[index].capacity) {
      left += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
          left: left,
        ),
      );
    }
    widgetList.add(Container());
    return widgetList;
  }

  @override
  void initState() {
    super.initState();
    setupSessions();
  }

  // Using TinderSwipeCard here - library from pub.dev which allows you very easily to have cards with same functionality as tinder cards
  // https://pub.dev/packages/flutter_tindercard/example

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: (MediaQuery.of(context).size.height + 120) * 0.6,
        child: TinderSwapCard(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.height * 0.85,
          cardBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSessionView(
                      session: sessions[index],
                    ),
                  ),
                ),
              },
              child: Hero(
                tag: 'Activity $index',
                child: Card(
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            sessions[index].activityImageUrl,
                            alignment: Alignment.lerp(
                                Alignment.center, Alignment.topCenter, .3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: 70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Activity Description",
                                      style: GoogleFonts.meriendaOne(
                                        color: HexColor("#000000"),
                                        fontSize: 18,
                                        letterSpacing: -1.5,
                                      ),

                                      // Text(
                                      //   "Activity Description",
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.w600,
                                      //     fontSize: 18,
                                      //     fontFamily: 'Merienda One',
                                      //   ),
                                    ),
                                    Text(sessions[index].activityDescription),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(top: 2),
                                height: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Stack(
                                        children: getAttendeeCircles(index),
                                      ),
                                    ),
                                    Text(
                                      '${sessions[index].capacity.length.toString()} / 6',
                                      style: GoogleFonts.meriendaOne(
                                        color: HexColor("#000000"),
                                        fontSize: 18,
                                        letterSpacing: -1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: 50,
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Resources",
                                    style: GoogleFonts.meriendaOne(
                                      color: HexColor("#000000"),
                                      fontSize: 18,
                                      letterSpacing: -1.5,
                                    ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.w500,
                                    //   fontSize: 16,
                                    // ),
                                  ),
                                  Text(sessions[index].resources.toString()),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: 50,
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Intensity",
                                    style: GoogleFonts.meriendaOne(
                                      color: HexColor("#000000"),
                                      fontSize: 18,
                                      letterSpacing: -1.5,
                                    ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.w500,
                                    //   fontSize: 16,
                                    // ),
                                  ),
                                  Text(sessions[index].intensityLevel),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: 65,
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleSessionView(
                                              session: sessions[index],
                                            ),
                                          ),
                                        ),
                                      },
                                      child: Text(
                                        "Read More",
                                        style: TextStyle(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: 80,
                                      child: Stack(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Positioned(
                                            child: Text(
                                              "by",
                                              style: GoogleFonts.meriendaOne(
                                                color: HexColor("#000000"),
                                                fontSize: 18,
                                                letterSpacing: -1.5,
                                              ),
                                            ),
                                            left: 5,
                                            top: 0,
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 25,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                  sessions[index]
                                                      .creator
                                                      .profileUrl),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          cardController: tinderCardController = CardController(),
          totalNum: sessions.length,
        ),
      ),
    );
  }
}
