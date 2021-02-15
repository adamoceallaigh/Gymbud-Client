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
        child: TinderSwapCard(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) => Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                sessions[index].activityImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          totalNum: sessions.length,
        ),
      ),
    );
  }
}
