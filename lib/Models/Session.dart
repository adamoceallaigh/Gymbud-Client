// Class Declaration of the Session Model
import 'package:Client/Models/User.dart';

class Session {
  String id,
      time,
      date,
      location,
      duration,
      activityType,
      activityName,
      activityDescription,
      activityGenderPreference,
      videoOrInPerson,
      intensityLevel,
      activityImageUrl;
  User creator;
  List resources;
  List<User> capacity;

  Session({
    this.id,
    this.creator,
    this.time,
    this.date,
    this.location,
    this.duration,
    this.activityType,
    this.activityName,
    this.activityDescription,
    this.activityGenderPreference,
    this.videoOrInPerson,
    this.intensityLevel,
    this.activityImageUrl,
    this.resources,
    this.capacity,
  });

  Session.fromJSON(Map<String, dynamic> data) {
    this.id = data['_id'];
    this.creator = User.fromJSON(data['Creator']);
    this.time = data['Time'];
    this.date = data['Date'];
    this.location = data['Location'];
    this.duration = data['Duration'];
    this.activityType = data['Activity_Type'];
    this.activityName = data['Activity_Name'];
    this.activityDescription = data['Activity_Description'];
    this.activityGenderPreference = data['Activity_Gender_Preference'];
    this.videoOrInPerson = data['Video_Or_In_Person'];
    this.intensityLevel = data['Intensity_Level'];
    this.activityImageUrl = data['Activity_Image_Url'];
    this.resources = data['Resources'];
    this.capacity = getUsersFromList(data['Capacity']);
  }

  List<User> getUsersFromList(users) {
    List<User> userList = new List<User>();
    for (var user in users) {
      userList.add(User.fromJSON(user));
    }

    return userList;
  }

  Map<String, dynamic> toJson() => {
        'Creator': this.creator,
        'Time': this.time,
        'Date': this.date,
        'Location': this.location,
        'Duration': this.duration,
        'Activity_Type': this.activityType,
        'Activiy_Name': this.activityName,
        'Activity_Description': this.activityDescription,
        'Activity_Gender_Preference': this.activityGenderPreference,
        'Video_Or_In_Person': this.videoOrInPerson,
        'Intensity_Level': this.intensityLevel,
        'Activity_Image_Url': this.activityImageUrl,
        'Resources': this.resources,
        'Capacity': this.capacity
      };

  @override
  String toString() {
    return this.toJson().toString();
  }
}
