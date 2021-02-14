import 'package:Client/Models/Session.dart';
import 'package:flutter/material.dart';
import 'package:Client/Controllers/SessionController.dart';
// import 'package:flutter_tindercard/flutter_tindercard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(child: Text(MediaQuery.of(context).size.toString())),
    );
  }
}
