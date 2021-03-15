//Class Declaration of the Class Model

class User {
  // Variables to hold all user values
  String id,
      username,
      email,
      password,
      profileUrl,
      name,
      gender,
      dob,
      preferredIntensity,
      preferredAgeRange,
      preferredDistanceRange,
      preferredActivity,
      fitnessLevel;
  List resources, messages, buds, activities, activitiesEnjoyed;

  // Variable to hold instance variable of user
  static Future<User> getUserInstance() async {
    return new User();
  }

  // Optional Named Constructor for User
  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.profileUrl,
    this.name,
    this.gender,
    this.dob,
    this.preferredIntensity,
    this.preferredAgeRange,
    this.preferredDistanceRange,
    this.preferredActivity,
    this.fitnessLevel,
    this.buds,
    this.activities,
    this.resources,
    this.activitiesEnjoyed,
    this.messages,
  });

  User.register(
    this.username,
    this.email,
    this.password,
    this.profileUrl,
    this.name,
    this.gender,
    this.dob,
    this.preferredIntensity,
    this.preferredAgeRange,
    this.preferredDistanceRange,
    this.preferredActivity,
    this.fitnessLevel,
    this.buds,
    this.activities,
    this.resources,
    this.activitiesEnjoyed,
    this.messages,
  );

  User.login(
    this.username,
    this.password,
  );

  //Constructor to pull json data values and make up a User model
  User.fromJSON(Map<String, dynamic> data) {
    this.id = data["_id"];
    this.username = data['Username'];
    this.email = data["Email"];
    this.password = data['Password'];
    this.profileUrl = data['Profile_Url'];
    this.name = data['Name'];
    this.gender = data["Gender"];
    this.dob = data["DOB"];
    this.preferredIntensity = data["Preferred_Intensity"];
    this.preferredAgeRange = data["Preferred_Age_Range"];
    this.preferredDistanceRange = data["Preferred_Distance_Range"];
    this.preferredActivity = data["Preferred_Activity"];
    this.fitnessLevel = data["Fitness_Level"];
    this.buds = data["Buds"];
    this.activities = data["Activities"];
    this.resources = data["Resources"];
    this.activitiesEnjoyed = data["Activities_Enjoyed"];
    this.messages = data["Messages"];
  }

  static Map<String, dynamic> toJson(User user) => {
        '_id': user.id,
        'Username': user.username,
        'Email': user.email,
        'Password': user.password,
        'Profile_Url': user.profileUrl,
        'Name': user.name,
        'Gender': user.gender,
        'DOB': user.dob,
        'Preferred_Intensity': user.preferredIntensity,
        'Fitness_Level': user.fitnessLevel,
        'Resources': user.resources,
        'Preferred_Age_Range': user.preferredAgeRange,
        'Preferred_Distance_Range': user.preferredDistanceRange,
        'Preferred_Activity': user.preferredActivity,
        'Messages': user.messages,
        'Activities_Enjoyed': user.activitiesEnjoyed,
        'Buds': user.buds,
        'Activities': user.activities
      };

  @override
  String toString() {
    return User.toJson(this).toString();
  }
}
