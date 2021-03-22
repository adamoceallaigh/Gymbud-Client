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
import 'package:Client/Presentation/General_Pages/Home_Screen.dart';
import 'package:Client/Presentation/Message_Management/Read_Message_Management/Read_Messages_View.dart';
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

  // Basic details up form key to be used for validation and on this page
  final _basicDetailsUpdateKey = GlobalKey<FormBuilderState>();

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

  checkWhereToNavigateByNavBarItemClick(String identifier) {
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
  getProfilePageBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 10),
        child: Column(
          children: [
            getTopButtonsBar(),
            getFollowersAndPicSection(),
            getNameAndLocation(),
            this.logged_in_user != null
                ? Container()
                : getFollowAndMessageBtns(),
            getProfileDetailsSection(),
          ],
        ),
      ),
    );
  }

  // Get Top Buttons Bar
  getTopButtonsBar() {
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
                    onTap: () => {Navigator.pop(context)},
                    child: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage()),
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
  getFollowersAndPicSection() {
    // Widget for second Row with Picture
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  logged_in_user?.buds != null
                      ? '${logged_in_user?.buds?.length}K'
                      : "4356K",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "followers".toUpperCase(),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: logged_in_user?.profileUrl != null
                  ? new NetworkImage(logged_in_user.profileUrl)
                  : null,
              radius: 50,
            ),
            Column(
              children: [
                Text(
                  logged_in_user?.activities != null
                      ? '${logged_in_user?.activities?.length}'
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
  getNameAndLocation() {
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
                      logged_in_user?.name != null
                          ? logged_in_user?.name
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

  getProfileDetailsSection() {
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
            Text(logged_in_user?.username != null
                ? logged_in_user?.username
                : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.mail),
            ),
            Text(
                logged_in_user?.email != null ? logged_in_user?.email : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.calendar_today),
            ),
            Text(logged_in_user?.dob != null ? logged_in_user?.dob : "Well"),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset("Resources/Images/${checkGender()}.svg"),
            ),
            Text(logged_in_user?.gender != null
                ? logged_in_user?.gender
                : "Well"),
          ],
        ),
      ],
    );
  }

  checkGender() {
    logged_in_user.gender = logged_in_user.gender.replaceAll(" ", "_");
    if (logged_in_user.gender == null)
      logged_in_user.gender = "Prefer Not To Say";
    switch (logged_in_user.gender) {
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

  // Logic Functions
  Future getImageFromSource(ImageSource imgSource) async {
    final pickedImage = await Constants.picker.getImage(source: imgSource);

    if (pickedImage != null) {
      dealWithUploadImageBtnClick(pickedImage.path);
    } else {
      print("No image selected");
    }
  }

  dealWithUploadImageBtnClick(String imagePath) async {
    try {
      // Image Url for image picked
      String _image_url =
          await context.read(image_provider).uploadImage(imagePath);
      if (_image_url != null) {
        logged_in_user.profileUrl = _image_url;
      }
    } catch (e) {
      print('caught error $e');
    }
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
          Constants.infoPopUp.message =
              "An error occurred while editing. Please try again";
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve Body
  getUpdateProfilePageBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 1080,
          padding: EdgeInsets.only(top: 40, left: 10),
          child: Column(
            children: [
              getUpdateTopButtonsBar(context),
              getUpdateBasicDetailsProfile(),
              updateButton(),
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
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.pop(context);
                      })
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

  getUpdateBasicDetailsProfile() {
    // Basic details up form key to be used for validation and on this page
    final _basicDetailsUpdateKey = GlobalKey<FormBuilderState>();

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
                        initialDate: DateTime(1970),
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
                        name: 'Gender',
                        allowClear: true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: Constants.genderOptions
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

  Widget updateButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ElevatedButton(
        child: Text('Update'),
        style: Constants.update_btn_style,
        onPressed: () => {
          // Check if the form is validated
          if (_basicDetailsUpdateKey.currentState.saveAndValidate())
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
          Expanded(child: Text(Constants.infoPopUp.message)),
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
