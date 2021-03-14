//Class Declaration of the Class Model

class User {
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
      videoOrInPerson,
      fitnessLevel;
  List resources, messages, buds, sessions, activitiesEnjoyed;
  User(
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
    this.videoOrInPerson,
    this.fitnessLevel,
    this.buds,
    this.sessions,
    this.resources,
    this.activitiesEnjoyed,
    this.messages,
  );

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
    this.videoOrInPerson,
    this.fitnessLevel,
    this.buds,
    this.sessions,
    this.resources,
    this.activitiesEnjoyed,
    this.messages,
  );

  User.login(
    this.username,
    this.password,
  );

  ///Constructor to pull json data values and make up a User model
  /// and return User to UserManager class to pass to page to be displayed
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
    this.videoOrInPerson = data["Video_Or_In_Person"];
    this.fitnessLevel = data["Fitness_Level"];
    this.buds = data["Buds"];
    this.sessions = data["Sessions"];
    this.resources = data["Resources"];
    this.activitiesEnjoyed = data["Activities_Enjoyed"];
    this.messages = data["Messages"];
  }

  Map<String, dynamic> toJson() => {
        '_id': this.id,
        'Username': this.username,
        'Email': this.email,
        'Password': this.password,
        'Profile_Url': this.profileUrl,
        'Name': this.name,
        'Gender': this.gender,
        'DOB': this.dob,
        'Preferred_Intensity': this.preferredIntensity,
        'Fitness_Level': this.fitnessLevel,
        'Resources': this.resources,
        'Preferred_Age_Range': this.preferredAgeRange,
        'Preferred_Distance_Range': this.preferredDistanceRange,
        'Video_Or_In_Person': this.videoOrInPerson,
        'Messages': this.messages,
        'Activities_Enjoyed': this.activitiesEnjoyed,
        'Buds': this.buds,
        'Sessions': this.sessions
      };

  @override
  String toString() {
    return this.toJson().toString();
  }

  // Making the Default user to start off from
  static User newUser() {
    return new User(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      [],
      [],
      [],
      [],
      [],
    );
  }
}
