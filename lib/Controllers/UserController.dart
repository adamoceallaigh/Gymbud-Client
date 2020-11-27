import 'package:Client/Models/User.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserController {
  List<User> users = List<User>();
  String url = "https://gymbud.herokuapp.com/api/v1/users";

  Future<List<User>> getUsers() async {
    Response response = await get('$url');
    if(response.statusCode == 200){
      var usersJSON = jsonDecode(response.body);
      for(var userJSON in usersJSON){
        users.add(User.fromJSON(userJSON));
      }
      //usersJSON.map((user) => users.add(User.fromJSON(user)));
    }
    
    return users;
  }
}