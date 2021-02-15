import 'package:Client/Models/Session.dart';
import 'package:flutter/material.dart';
import 'package:Client/Controllers/SessionController.dart';
//Importing TinderSwipeCard here allowing me to have same functionality easily as tinder cards
import 'package:flutter_tindercard/flutter_tindercard.dart';

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
            return Card(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: Image.network(
              //     sessions[index].activityImageUrl,
              //     height: 10.0,
              //     // fit: BoxFit.cover,
              //   ),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                  SizedBox(height: 8),
                  Expanded(
                    child: Container(),
                  ),
                ],
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
