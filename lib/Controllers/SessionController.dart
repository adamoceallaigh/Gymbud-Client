import 'package:Client/Models/Session.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Session Controller Class Definition to conduct session management operations
class SessionController {
  List<Session> sessions = List<Session>();
  String url = "https://gymbud.herokuapp.com/api/v1/sessions";

  // Checks Response from the backend server, to check if everything is OK
  Future<List<Session>> getSessions() async {
    Response response = await get('$url');
    if (response.statusCode == 200) {
      var sessionsJSON = jsonDecode(response.body);
      for (var sessionJSON in sessionsJSON) {
        sessions.add(Session.fromJSON(sessionJSON));
      }
      //sessionsJSON.map((session) => sessions.add(session.fromJSON(session)));
    }

    return sessions;
  }

  Future<Session> createsession(Session session) async {
    Response response =
        await http.post('https://gymbud.herokuapp.com/api/v1/sessions',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(session.toJson()));
    if (response.statusCode == 200) {
      var sessionJSON = jsonDecode(response.body);
      return Session.fromJSON(sessionJSON);
    }
    return null;
  }
}
