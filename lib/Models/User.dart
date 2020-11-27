class User {
    String id, userName , password , name , gender , dob , preferredIntensity, preferredAgeRange,videoOrInPerson, fitnessLevel;
    List resources , messages , matches , sessions;
    User(
    this.id,
    this.userName , 
    this.password , 
    this.name , 
    this.gender, 
    this.dob , 
    this.preferredIntensity , 
    this.preferredAgeRange , 
    this.videoOrInPerson , 
    this.fitnessLevel , 
    this.matches , 
    this.sessions ,
    this.resources,
    this.messages 
  );
  User.fromJSON(Map<String, dynamic> data) {
    this.id = data["_id"];
    this.userName = data['userName'];
    this.password = data['password'];
    this.name = data['Name'];
    this.gender = data["Gender"];
    this.dob = data["DOB"];
    this.preferredIntensity = data["Preferred_Intensity"];
    this.preferredAgeRange = data["Preferred_Age_Range"];
    this.videoOrInPerson = data["Video_Or_In_Person"];
    this.fitnessLevel = data["Fitness_Level"];
    this.matches = data["Matches"];
    this.sessions = data["Sessions"];
    this.resources = data["Resources"];
    this.messages = data["Messages"];
  }
}