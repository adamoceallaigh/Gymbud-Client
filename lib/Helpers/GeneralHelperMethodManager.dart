// // Imports

// // Library Imports
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Helpers/Libs_Required.dart';
import 'package:Client/Infrastructure/Models/Models_Required.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/General_Pages/Calendar_View.dart';
import 'package:Client/Presentation/General_Pages/Favourites_View.dart';
import 'package:Client/Presentation/General_Pages/Gymbud_Plus_View.dart';
import 'package:Client/Presentation/Message_Management/Read_Message_Management/Read_Messages_View.dart';
import 'package:Client/Presentation/User_Management/Create_User_Management/Create_User_Upload_Photo_Success.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Profile_Page.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_Users_Buds_View.dart';
import 'package:Client/Presentation/User_Management/Update_User_Management/Update_User_Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Client/Config/configVariables.dart' as Constants;

// // Page Imports

class GeneralHelperMethodManager {
  final User logged_in_user;
  final int index;
  final BuildContext context;
  GeneralHelperMethodManager({this.logged_in_user, this.index, this.context});

  Activity newActivity = Activity();

  List<Widget> getAttendeeCircles() {
    List<Widget> widgetList = [];
    double right = 0;
    if (this.logged_in_user.activities[index].participants.length == 1)
      right = 0;
    else
      right = -18;
    for (var user in this.logged_in_user.activities[index].participants) {
      right += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
          bottom: 0,
          right: right,
        ),
      );
      if (this.logged_in_user.activities[index].participants.indexOf(user) >
          2) {
        break;
      }
    }
    return widgetList;
  }

  // Logic Functions

  getImageFromSource(ImageSource imgSource, {String place = ""}) async {
    final pickedImage =
        await Constants.GeneralVariableStore.picker.getImage(source: imgSource);

    if (pickedImage != null) {
      if (place == "Activity")
        return dealWithUploadImageBtnClick(pickedImage.path,
            context: context, place: place);
      dealWithUploadImageBtnClick(pickedImage.path,
          context: context, place: place);
    } else {
      print("No image selected");
    }
  }

  dealWithUploadImageBtnClick(String imagePath,
      {BuildContext context = null, String place = ""}) async {
    try {
      if (place == "") return;
      // Get Image Url for image picked
      String _image_url =
          await context.read(image_provider).uploadImage(imagePath);
      if (_image_url != null) {
        if (place == "Activity") return _image_url;
        logged_in_user.profileUrl = _image_url;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadPhotoSucess(user: logged_in_user)));
      }
    } catch (e) {
      print('caught error $e');
    }
  }

  checkWhereToNavigateByNavBarItemClick(String identifier) async {
    dynamic page = "";
    switch (identifier) {
      case "Profile":
        page = ProfilePage();
        break;
      case "Buds":
        page = BudsView();
        break;
      case "Calendar":
        page = CalendarView();
        break;
      case "Messages":
        List<Conversation> all_conversations =
            await context.read(conversations_provider).readConversations();
        context
            .read(conversations_notifier_provider)
            .addConversations(all_conversations);
        page = MessagesView();
        break;
      case "Favourites":
        page = FavouritesView();
        break;
      case "Gymbud Plus":
        page = GymbudPlusView();
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Retrieve Body
  getProfilePageBody(temporary_user_notifier) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 10),
        child: Column(
          children: [
            getTopButtonsBar(temporary_user_notifier),
            getFollowersAndPicSection(temporary_user_notifier),
            getNameAndLocation(temporary_user_notifier),
            temporary_user_notifier.username != null
                ? getFollowAndMessageBtns()
                : Container(),
            getProfileDetailsSection(temporary_user_notifier),
          ],
        ),
      ),
    );
  }

  takeOffTemporaryUser(temporary_user_notifier) {
    if (temporary_user_notifier.username != null) {
      context
          .read(temp_user_notifier_provider)
          .deleteTempUser(context.read(temp_user_notifier_provider.state));
    }
  }

  // Get Top Buttons Bar
  getTopButtonsBar(temporary_user_notifier) {
    return // Back button and top bar widget
        Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                      takeOffTemporaryUser(temporary_user_notifier),
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            if (temporary_user_notifier.username == null)
              Container(
                margin: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(),
                      ),
                    )
                    // Navigator.push(context, Route.UpdateProfilePage())
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Edit"),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  // Get Followers and Pic Section
  getFollowersAndPicSection(temporary_user_notifier) {
    var usertype = temporary_user_notifier.username == null
        ? logged_in_user
        : temporary_user_notifier;
    // Widget for second Row with Picture
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  usertype?.buds != null
                      ? '${usertype?.buds?.length}K'
                      : "4356K",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "followers".toUpperCase(),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: usertype?.profileUrl != null
                  ? new NetworkImage(usertype.profileUrl)
                  : null,
              radius: 50,
            ),
            Column(
              children: [
                Text(
                  usertype?.activities != null
                      ? '${usertype?.activities?.length}'
                      : "743",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Past Activites".toUpperCase(),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // Widget for third row with name and loaction
  getNameAndLocation(temporary_user_notifier) {
    var usertype = temporary_user_notifier.username == null
        ? logged_in_user
        : temporary_user_notifier;
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 135),
                    child: Text(
                      usertype?.name != null
                          ? usertype?.name
                          : "Sarah Geller".toUpperCase(),
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: HexColor("#BDBDBD"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "France",
                        style: TextStyle(
                          color: HexColor("#BDBDBD"),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  getFollowAndMessageBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 5,
              ),
              Text(
                "Follow".toUpperCase(),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          style: ButtonProducer.getFollowGymbudBtn(),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () => {},
          child: Text(
            "Message".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          style: ButtonProducer.getMessageGymbudBtn(),
        )
      ],
    );
  }

  getProfileDetailsSection(temporary_user_notifier) {
    var usertype = temporary_user_notifier.username == null
        ? logged_in_user
        : temporary_user_notifier;
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.person),
            ),
            Text(usertype?.username != null ? usertype?.username : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.mail),
            ),
            Text(usertype?.email != null ? usertype?.email : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.calendar_today),
            ),
            Text(usertype?.dob != null ? usertype?.dob : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                  "Resources/Images/${checkGender(usertype)}.svg"),
            ),
            Text(usertype?.gender != null ? usertype?.gender : "Well"),
          ],
        ),
      ],
    );
  }

  static checkGender(usertype) {
    usertype?.gender = usertype?.gender?.replaceAll(" ", "_");
    if (usertype?.gender == null) usertype?.gender = "Prefer Not To Say";
    switch (usertype?.gender) {
      case "Prefer_Not_To_Say":
      case "Non-Binary":
        return "All_Gender";
        break;
      case "Male":
      case "male":
        return "Male";
        break;
      case "Female":
      case "female":
        return "Female";
        break;
    }
  }

  static dynamic checkDaysUntil(String number) {
    number = number ?? "";
    int numberInt = int.tryParse(number);
    switch (numberInt) {
      case 1:
        return Colors.redAccent;
      case 2:
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.greenAccent;
      case 5:
        return Colors.blueAccent;
      default:
        return HexColor("EB9661");
    }
  }

  static String getActivitySVG(String type) {
    if (type == null) return "Gymbud_Logo";
    var activityTypes = {
      "Home_Workout": "Home_Workout",
      "Gym_Workout": "GymWeights",
      "Outdoor_Activity": "Outdoor_Act"
    };
    return activityTypes[type];
  }

  setBasicDetailsUpdate(Map<String, dynamic> formValues) {
    // Setting formValues equal to user object values
    logged_in_user.username = formValues['Username'];
    logged_in_user.email = formValues['Email'];
    logged_in_user.name = formValues["Name"];
    logged_in_user.gender = formValues["Gender"];
    logged_in_user.dob = formValues["DOB"].toString().split(" ").first;

    _updateUser();
  }

  _updateUser() async {
    try {
      // // Result from logging in user could either be a error or user
      dynamic createdUser =
          await context.read(user_provider).updateUser(logged_in_user);

      // Checking if the result is a error
      if (createdUser.runtimeType == InformationPopUp) {
        if (createdUser.message != null) {
          // Displaying error in pop up by setting the state
          // setState(() {
          //   infoPopUp = createdUser;
          // });
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (createdUser.username != null) {
          await context.read(user_notifier_provider).createUser(createdUser);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Constants.GeneralVariableStore.infoPopUp.message =
              "An error occurred while editing. Please try again";
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve Body
  getUpdateProfilePageBody(BuildContext context, _basicDetailsUpdateKey) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 1080,
          padding: EdgeInsets.only(top: 40, left: 10),
          child: Column(
            children: [
              getUpdateTopButtonsBar(context),
              getUpdateBasicDetailsProfile(_basicDetailsUpdateKey),
              updateButton(_basicDetailsUpdateKey),
            ],
          ),
        ),
      ),
    );
  }

  getUpdateTopButtonsBar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () => {
                      Navigator.pop(context)
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      //   Navigator.pop(context);
                      // })
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  setUpDob(_basicDetailsUpdateKey) {
    _basicDetailsUpdateKey.currentState.fields['DOB']
        .didChange(DateTime.parse(logged_in_user?.dob));
  }

  getUpdateBasicDetailsProfile(_basicDetailsUpdateKey) {
    // // Basic details up form key to be used for validation and on this page
    // final _basicDetailsUpdateKey = GlobalKey<FormBuilderState>();
    return Container(
      child: FormBuilder(
        key: _basicDetailsUpdateKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              if (logged_in_user.profileUrl != null)
                Container(
                  height: 150,
                  width: 200,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(logged_in_user.profileUrl),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email:"),
                      FormBuilderTextField(
                        initialValue: logged_in_user?.email,
                        name: "Email",
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username:"),
                      FormBuilderTextField(
                        initialValue: logged_in_user?.username,
                        name: "Username",
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.maxLength(context, 30)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:"),
                      FormBuilderTextField(
                        initialValue: logged_in_user?.name,
                        name: 'Name',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 8)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DOB:"),
                      FormBuilderDateTimePicker(
                        name: 'DOB',
                        lastDate: DateTime(DateTime.now().year - 18),
                        initialDate: DateTime.parse(logged_in_user?.dob),
                        inputType: InputType.date,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender:"),
                      FormBuilderDropdown(
                        initialValue: logged_in_user?.gender,
                        name: 'Gender',
                        allowClear: true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: Constants.ActivityVariableStore.mainGenderOptions
                            .map((genderOption) => genderOption.description)
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text('$gender'),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget updateButton(_basicDetailsUpdateKey) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ElevatedButton(
        child: Text(
          'Update',
          style: GoogleFonts.delius(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        style: Constants.StyleVariableStore.sign_up_button_style,
        onPressed: () => {
          setUpDob(_basicDetailsUpdateKey),
          // Check if the form is validated
          if (_basicDetailsUpdateKey?.currentState?.saveAndValidate())
            {
              // Setting the valid formValues equal to user object values
              setBasicDetailsUpdate(_basicDetailsUpdateKey.currentState.value)
            }
        },
      ),
    );
  }

  List<Widget> getAttendeeCirclesMatchView(
      int index, List<Activity> activities) {
    List<Widget> widgetList = [];
    double left = 0;
    if (activities[index].participants.length == 1)
      left = 0;
    else
      left = -18;
    for (var user in activities[index].participants) {
      left += 18;
      widgetList.add(
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profileUrl),
          ),
          left: left,
        ),
      );
    }
    widgetList.add(Container());
    return widgetList;
  }

  // Checking for Errors Pop Up
  Widget checkForLoginErrorPopUp() {
    return Container(
      color: Colors.amberAccent,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
              child: Text(Constants.GeneralVariableStore.infoPopUp.message)),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {
              // setState(() {
              //   infoPopUp.message = null;
              // })
            },
          ),
        ],
      ),
    );
  }

  void checkProvider(
      String placeToChangeFrom, String whatToChange, String valueToChangeTo) {
    switch (placeToChangeFrom) {
      case "Activity":
        if (whatToChange == "Type") {
          context.read(activity_notifier_provider.state).activityType =
              valueToChangeTo;
          break;
        } else {
          context
              .read(activity_notifier_provider.state)
              .activityGenderPreference = valueToChangeTo;
          break;
        }
        break;
      case "User":
        context.read(user_notifier_provider.state).preferredActivity =
            valueToChangeTo;
        break;
    }
  }

  // Retrieves the word labels for the sliders based on input given
  String getLabel(double percLevel, String mode) {
    // print(Constants.ActivityVariableStore.activities);
    // print(Constants.ActivityVariableStore.activityModesSliderDouble);
    return Constants.ActivityVariableStore.activityModesSliderStrings[mode]
        [percLevel];
  }

  double getPercentLevel(String sliderStringLevel, String mode) {
    return Constants.ActivityVariableStore.activityModesSliderDouble[mode]
        [sliderStringLevel];
  }

  void setActivityPreferencesFromSlider(
      String whatToChange, String whatProviderToChange, dynamic changeValue) {
    switch (whatProviderToChange) {
      case "Activity":
        if (whatToChange == "Fitness") {
          context.read(activity_notifier_provider.state).activityFitnessLevel =
              changeValue;
          break;
        } else if (whatToChange == "Intensity") {
          context
              .read(activity_notifier_provider.state)
              .activityIntensityLevel = changeValue;
          break;
        } else {
          context.read(activity_notifier_provider.state).activityBudgetLevel =
              changeValue;
          break;
        }
        break;
      case "User":
        if (whatToChange == "Fitness") {
          context.read(user_notifier_provider.state).fitnessLevel = changeValue;
          break;
        } else if (whatToChange == "Intensity") {
          context.read(user_notifier_provider.state).preferredIntensity =
              changeValue;
          break;
        }
    }
  }
}

// // Create the button to navigate to the basic details page
// Widget createContinueToBasicDetailsPageBtn() {
//   return Container(
//     width: 300,
//     height: 60,
//     child: ElevatedButton(
//       style: ButtonProducer.getOrangeGymbudBtn(),
//       onPressed: () {
//         //Check if the form is validated
//         if (_basicDetailsUpdateKey.currentState.saveAndValidate()) {
//           setBasicDetailsUpdate(
//             _basicDetailsUpdateKey.currentState.value,
//           );
//         }
//       },
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           "Update",
//           style: GoogleFonts.concertOne(
//             fontSize: 30,
//             // letterSpacing: -1.5,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Creating the Sign Up Button and dealing with signing up first part
