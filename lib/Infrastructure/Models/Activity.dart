// Imports

// Library Imports

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';

// Class Declaration of the Activity Model
class Activity {
  // Variables to hold all activity values
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
  dynamic creator;
  List resources;
  List<dynamic> participants;

  // Variable to hold instance variable of user
  static Future<Activity> getActivityInstance() async {
    return new Activity();
  }

  // Optional Named Constructor for Activity
  Activity({
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

  // Constructor to pull json data values and make up an Activity model
  Activity.fromJSON(Map<String, dynamic> data) {
    this.id = data['_id'];
    this.creator = data['Creator'].runtimeType == String
        ? data['Creator']
        : User.fromJSON(data['Creator']);
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
    this.participants = List<dynamic>.from(
      data['Participants'].map(
        (user) => user.runtimeType == String
            ? data["Participants"]
            : User.fromJSON(user),
      ),
    );
  }

  static Map<String, dynamic> toJson(Activity activity) => {
        'Creator': User.toJson(activity.creator),
        'Time': activity.time,
        'Date': activity.date,
        'Location': activity.location,
        'Duration': activity.duration,
        'Activity_Type': activity.activityType,
        'Activity_Name': activity.activityName,
        'Activity_Description': activity.activityDescription,
        'Activity_Gender_Preference': activity.activityGenderPreference,
        'Intensity_Level': activity.activityIntensityLevel,
        'Fitness_Level': activity.activityFitnessLevel,
        'Budget_Level': activity.activityBudgetLevel,
        'Activity_Image_Url': activity.activityImageUrl,
        'Resources': activity.resources,
        'Participants': activity.participants
      };

  @override
  String toString() {
    return Activity.toJson(this).toString();
  }
}
