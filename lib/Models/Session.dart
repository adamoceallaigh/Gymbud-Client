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
      activityIntensityLevel,
      activityBudgetLevel,
      activityFitnessLevel,
      activityImageUrl;
  User creator;
  List resources;
  List<User> participants;

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
    this.activityIntensityLevel,
    this.activityBudgetLevel,
    this.activityFitnessLevel,
    this.activityImageUrl,
    this.resources,
    this.participants,
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
    this.activityIntensityLevel = data['Intensity_Level'];
    this.activityBudgetLevel = data['Budget_Level'];
    this.activityFitnessLevel = data['Fitness_Level'];
    this.activityImageUrl = data['Activity_Image_Url'];
    this.resources = data['Resources'];
    this.participants = getUsersFromList(data['Participants']);
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
        'Intensity_Level': this.activityIntensityLevel,
        'Fitness_Level': this.activityFitnessLevel,
        'Budget_Level': this.activityBudgetLevel,
        'Activity_Image_Url': this.activityImageUrl,
        'Resources': this.resources,
        'Participants': this.participants
      };

  @override
  String toString() {
    return this.toJson().toString();
  }
}
