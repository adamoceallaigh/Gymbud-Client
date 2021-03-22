// Variables to distinguish the different activity preferences
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/InformationPopUp.dart';
import 'package:Client/Presentation/Activity_Management/Components/Activity_Option.dart';

final activityOptions = [
  new Activity_Option("Home\n Workout", "Home_Workout",
      "Resources/Images/Home_Workout.svg", false),
  new Activity_Option(
      "Gym \nWorkout", "Gym_Workout", "Resources/Images/GymWeights.svg", false),
  new Activity_Option("Outdoor\n Activity", "Outdoor_Activity",
      "Resources/Images/Outdoor_Act.svg", false)
];
const double _defaultIntensity = 20.0;
const double _defaultActivityLevel = 20.0;

const double _pageHeight = 1000;

// Styling for Signup Button
final ButtonStyle update_btn_style = ButtonProducer.getOrangeGymbudBtn();

// Variable to hold my gender options
List<String> genderOptions = [
  "Male",
  "Female",
  "Prefer Not To Say",
  "Non-Binary"
];

// Info  pop up to be used to alert user to a error within their input
InformationPopUp infoPopUp = new InformationPopUp();

// Image picker necessary for this page
final picker = ImagePicker();

// Variable to hold all my drawerItems
List<Map> drawerItems = [
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

// Array to hold the resources
final resources = [
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
final activities = [
  "Swim",
  "Run",
  "Walk",
  "At Home Workout",
  "Gym",
  "Skip",
  "Hike",
  "Cycle"
];
