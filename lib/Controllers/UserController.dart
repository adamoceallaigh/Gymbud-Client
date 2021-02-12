//Imports and Variable Declarations
import 'package:Client/Models/User.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// User Controller Class Definition to conduct user management operations
class UserController {
  List<User> users = List<User>();
  String url = "https://gymbud.herokuapp.com/api/v1/users";

  // Checks Response from the backend server, to check if everything is OK
  Future<List<User>> getUsers() async {
    Response response = await get('$url');
    if (response.statusCode == 200) {
      var usersJSON = jsonDecode(response.body);
      for (var userJSON in usersJSON) {
        users.add(User.fromJSON(userJSON));
      }
      //usersJSON.map((user) => users.add(User.fromJSON(user)));
    }

    return users;
  }

  Future<User> createUser(User user) async {
    Response response =
        await http.post('https://gymbud.herokuapp.com/api/v1/users',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "userName": user.userName,
              "password": user.password,
              "Profile_Url": user.profileUrl,
              "Name": user.name,
              "Gender": user.gender,
              "DOB": user.dob,
              "Preferred_Intensity": user.preferredIntensity,
              "Fitness_Level": user.fitnessLevel,
              "Resources": jsonEncode(user.resources),
              "Preferred_Age_Range": user.preferredAgeRange,
              "Video_Or_In_Person": user.videoOrInPerson
            }));
    if (response.statusCode == 200) {
      var userJSON = jsonDecode(response.body);
      return User.fromJSON(userJSON);
    }
    return null;
  }

  bool loginUser(User user) {
    if (user.userName == "harrym" && user.password == "go")
      return true;
    else if (user.userName == "heftyboy" && user.password == "friedchicken")
      return true;
    return false;
  }
}
