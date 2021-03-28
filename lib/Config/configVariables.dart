// Imports

// Library Imports

// Page Imports
import 'dart:math';

import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Presentation/Activity_Management/Components/Activity_Option.dart';
import 'package:uuid/uuid.dart';

// Activity Variables

class ActivityVariableStore {
  static List<GeneralOption> mainActivityOptions = [
    new GeneralOption("Home\n Workout", "Home_Workout",
        "Resources/Images/Home_Workout.svg", false),
    new GeneralOption("Gym \nWorkout", "Gym_Workout",
        "Resources/Images/GymWeights.svg", false),
    new GeneralOption("Outdoor\n Activity", "Outdoor_Activity",
        "Resources/Images/Outdoor_Act.svg", false)
  ];

  static List<GeneralOption> mainGenderOptions = [
    new GeneralOption("Male", "Male", "Resources/Images/Male.svg", false),
    new GeneralOption("Female", "Female", "Resources/Images/Female.svg", false),
    new GeneralOption("No Preference", "No_Preference",
        "Resources/Images/All_Gender.svg", false)
  ];

  static double defaultIntensity = 20.0;
  static double defaultActivityLevel = 20.0;
  static double defaultBudgetLevel = 10.0;
  static List<String> genderOptionsActivities = [
    "Male",
    "Female",
    "No Preference"
  ];

  // Variable to hold my activity preference modes slider string
  static Map<String, Map<double, String>> activityModesSliderStrings = {
    "Fitness": {
      0.0: "Inactive",
      20.0: "Slightly Active",
      40.0: "Moderately Active",
      60.0: "Active",
      80.0: "Very Active",
      100.0: "Super Active"
    },
    "Intensity": {
      0.0: "Not Intensive",
      20.0: "Slightly Intensive",
      40.0: "Moderately Intensive",
      60.0: "Intensive",
      80.0: "Very Intensive",
      100.0: "Super Intensive"
    },
    "Budget": {
      0.0: "Free",
      20.0: "Slightly Expensive",
      40.0: "Moderately Expensive",
      60.0: "Expensive",
      80.0: "Very Expensive",
      100.0: "Super Expensive"
    }
  };

  static Map<String, Map<String, double>> activityModesSliderDouble = {
    "Fitness": {
      "Inactive": 0.0,
      "Slightly Active": 20.0,
      "Moderately Active": 40.0,
      "Active": 60.0,
      "Very Active": 80.0,
      "Super Active": 100.0
    },
    "Intensity": {
      "Not Intensive": 0.0,
      "Slightly Intensive": 20.0,
      "Moderately Intensive": 40.0,
      "Intensive": 60.0,
      "Very Intensive": 80.0,
      "Super Intensive": 100.0
    },
    "Budget": {
      "Free": 0.0,
      "Slightly Expensive": 20.0,
      "Moderately Expensive": 40.0,
      "Expensive": 60.0,
      "Very Expensive": 80.0,
      "Super Expensive": 100.0
    }
  };

  // Array to hold the resources
  static List<String> resources = [
    "Bicycle",
    "Assault Bike",
    "Trap Bar",
    "Barbells",
    "Plates",
    "Bands",
    "Suspension Trainers",
    "Skipping Rope",
    "Treadmill",
    "Slam Ball",
    "Kettle Bells"
  ];

  // Array to hold the outdoor activities
  static List<String> activities = [
    "Swim",
    "Run",
    "Walk",
    "At Home Workout",
    "Gym",
    "Skip",
    "Hike",
    "Cycle"
  ];
}

// General Variables

class GeneralVariableStore {
  static double pageHeight = 1000;

  // Info  pop up to be used to alert user to a error within their input
  static InformationPopUp infoPopUp = new InformationPopUp();

  // Image picker necessary for this page
  static ImagePicker picker = ImagePicker();

  // Variable to hold all my drawerItems
  static List<Map> drawerItems = [
    {
      'icon': Icons.person,
      'title': 'Profile',
    },
    {
      'icon': SvgPicture.asset(
        "Resources/Images/Buds_Icon.svg",
        height: 30,
      ),
      'title': 'Buds',
      'type': 'SVG'
    },
    {
      'icon': SvgPicture.asset(
        "Resources/Images/Calendar_Icon.svg",
        height: 30,
      ),
      'title': 'Calendar',
      'type': 'SVG'
    },
    {
      'icon': Icons.mail,
      'title': 'Messages',
    },
    {
      'icon': Icons.favorite,
      'title': 'Favourites',
    },
    {
      'icon': Icons.add,
      'title': 'Gymbud Plus',
    },
  ];

  static List<User> fakeUsers = [
    User(
      id: new Uuid().v4(),
      username: "michelleadams",
      email: "michelleadams@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1949&q=80",
      name: "Michelle Adams",
      gender: "Female",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "robharte",
      email: "robharte@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1562771379-eafdca7a02f8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      name: "Rob Harte",
      gender: "Male",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "jennypeters",
      email: "jennypeters@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1576226565048-f377166d7e7f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=958&q=80",
      name: "Jenny Peters",
      gender: "Female",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "peterparker",
      email: "peterparker@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1530986380366-2c4caefe7e4b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80",
      name: "Peter Parker",
      gender: "Male",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "obiwilliams",
      email: "obiwilliams@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1480264104733-84fb0b925be3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
      name: "Obi Williams",
      gender: "Male",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "sarah_johnson",
      email: "sarahjohnson@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1505915909330-c082888680af?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=582&q=80",
      name: "Sarah Johnson",
      gender: "Female",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "stephanieryan",
      email: "stephanieryan@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1480179087180-d9f0ec044897?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=958&q=80",
      name: "Stephanie Ryan",
      gender: "Female",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
    User(
      id: new Uuid().v4(),
      username: "amycolt",
      email: "amycolt@gmail.com",
      profileUrl:
          "https://images.unsplash.com/photo-1517438984742-1262db08379e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=928&q=80",
      name: "Amy Colt",
      gender: "Female",
      dob: "2002-01-24",
      preferredIntensity: "Moderately Intensive",
      preferredAgeRange: "38.523552389705884 - 74.00404986213235",
      preferredDistanceRange: "35",
      fitnessLevel: "Active",
      buds: List<int>.filled(new Random().nextInt(400), 0),
      activities: List<int>.filled(new Random().nextInt(4), 0),
    ),
  ];

  static List<Activity> fakeActivities = [
    Activity(
      activityType: "Home_Workout",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "1",
    ),
    Activity(
      activityType: "Gym_Workout",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "1",
    ),
    Activity(
      activityType: "Home_Workout",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "3",
    ),
    Activity(
      activityType: "Outdoor_Activity",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "5",
    ),
    Activity(
      activityType: "Outdoor_Activity",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "3",
    ),
    Activity(
      activityType: "Gym_Workout",
      creator: fakeUsers[new Random().nextInt(fakeUsers.length - 1)],
      date: "7",
    ),
  ];
}

// Styling Variables

class StyleVariableStore {
  static ButtonStyle update_btn_style = ButtonProducer.getOrangeGymbudBtn();
  static List<BoxShadow> shadowList = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 30,
      offset: Offset(10.0, 10.0),
      // offset: Offset(0, 10),
    )
  ];
  static ButtonStyle upload_pic_btn_style =
      ButtonProducer.getUploadImageGymbudBtn();

  // Styling for Login Button
  static ButtonStyle login_btn_style = ButtonProducer.getLoginGymbudBtn();

  // Setting up the button styles for login/ signup buttons
  static ButtonStyle sign_up_button_style = ButtonProducer.getSignUpGymbudBtn();
  // ButtonStyle login_button_style = ButtonProducer.getWhiteGymbudBtn("eeeeee");

  static ButtonStyle orange_gymbud_btn = ButtonProducer.getOrangeGymbudBtn();
}
