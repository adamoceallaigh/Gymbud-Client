import 'package:Client/Controllers/SessionController.dart';
import 'package:Client/Helper_Widgets/hex_color.dart';
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/Models/Session.dart';
import 'package:Client/Models/User.dart';
// import 'package:Client/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleSessionView extends StatefulWidget {
  final Session session;
  final User user;

  SingleSessionView({Key key, @required this.session, @required this.user})
      : super(key: key);

  @override
  _SingleSessionViewState createState() => _SingleSessionViewState();
}

class _SingleSessionViewState extends State<SingleSessionView> {
  InformationPopUp infoPopUp;

  @override
  Widget build(BuildContext context) {
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
      body: getSingleSessionBody(),
    );
  }

  List<Widget> getAttendeeCircles() {
    List<Widget> widgetList = new List<Widget>();
    for (var user in widget.session.capacity) {
      widgetList.add(
        CircleAvatar(
          backgroundImage: NetworkImage(user.profileUrl),
        ),
      );
    }
    widgetList.add(Container());
    return widgetList;
  }

  void addUserToSession(sessionId, userId) {
    SessionController sessionController = new SessionController();
    Future<String> result =
        sessionController.addUserToSession(sessionId, userId);
  }

  Widget getSingleSessionBody() {
    return SingleChildScrollView(
      child: Container(
          height: 1330,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 470,
                child: Hero(
                  tag: 'Activity ${widget.session.hashCode}',
                  child: Image.network(
                    widget.session.activityImageUrl,
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
                      color: Colors.yellow,
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
                              Text(widget.session.activityName),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      color: Colors.pink,
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
                              Text(widget.session.activityType),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      color: Colors.purple,
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
                              Text(widget.session.activityGenderPreference),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
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
                                                child: Icon(Icons.date_range)),
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
                                          // color: Colors.orange,
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
                                                '${widget.session.date}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
//                                           SizedBox(width: 15.0),
                                            Expanded(
                                              child: Text(
                                                '${widget.session.time}',
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
                      color: Colors.green,
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
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              '${widget.session.capacity.length}'),
                                    ],
                                  ),
                                ),
                                // Text(
                                //   "Participants ⚧ ${widget.session.capacity.length}",
                                //   style: GoogleFonts.meriendaOne(
                                //     color: HexColor("#000000"),
                                //     fontSize: 18,
                                //     letterSpacing: -1.5,
                                //   ),
                                // ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Colors.red,
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
                              Text(widget.session.resources.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () => {
                        addUserToSession(widget.session.id, widget.user.id),
                      },
                      child: Text("I want to do this/I'm Available"),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
