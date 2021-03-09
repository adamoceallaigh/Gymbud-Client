import 'package:Client/Models/Session.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Session Controller Class Definition to conduct session management operations
class SessionController {
  List<Session> sessions = [];
  String url = "https://gymbud.herokuapp.com/api/v1/sessions";
  Uri urlLocal = Uri.parse('http://10.0.2.2:7000/api/v1/sessions');

  // Checks Response from the backend server, to check if everything is OK
  Future<List<Session>> getSessions() async {
    http.Response response = await get(urlLocal);
    if (response.statusCode == 200) {
      var sessionsJSON = jsonDecode(response.body);
      for (var sessionJSON in sessionsJSON) {
        sessions.add(Session.fromJSON(sessionJSON));
      }
    }

    return sessions;
  }

  Future<bool> createsession(Session session) async {
    try {
      http.Response response = await http.post(urlLocal,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'credentials': 'include'
          },
          body: jsonEncode(session.toJson()));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('caught error $e');
    }
    return null;
  }

  // Add User To Session
  Future<String> addUserToSession(String sessionId, String userId) async {
    Uri urlLocal = Uri.parse(
        'http://10.0.2.2:7000/api/v1/sessions/addUser?sessionId=$sessionId&userId=$userId');
    http.Response response = await http.post(urlLocal,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'credentials': 'include'
        },
        // withCredentials: true,
        body: jsonEncode({sessionId: sessionId}));
    if (response.statusCode == 200) {
      var responseJSON = jsonDecode(response.body);
      return responseJSON[0];
    }
    return null;
  }
}
