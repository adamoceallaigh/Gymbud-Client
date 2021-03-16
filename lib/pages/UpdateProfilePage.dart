// Imports

// Library Imports

import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// Page Imports
import 'package:Client/Models/User.dart';
import 'package:Client/Helper_Widgets/ButtonProducer.dart';
import 'package:Client/Helper_Widgets/GeneralNetworkingMethodManager.dart';

// Template to make the UpdateProfile View Page
class UpdateProfilePage extends StatefulWidget {
  /*
    Setting up variables for this page
  */

  // This is the way we are going to save the values across the pages
  final User user;
  UpdateProfilePage({Key key, this.user}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

// State to manage the template for this page
class _UpdateProfilePageState extends State<UpdateProfilePage> {
  /*
    Setting up variables for this page
  */

  // Basic details up form key to be used for validation and on this page
  final _basicDetailsUpdateKey = GlobalKey<FormBuilderState>();

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

  // Logic Functions
  Future getImageFromSource(ImageSource imgSource, BuildContext context) async {
    final pickedImage = await picker.getImage(source: imgSource);

    if (pickedImage != null) {
      dealWithUploadImageBtnClick(pickedImage.path, context: context);
    } else {
      print("No image selected");
    }
  }

  dealWithUploadImageBtnClick(String imagePath,
      {BuildContext context = null}) async {
    try {
      // Image Url for image picked
      String _image_url = await GeneralNetworkingMethodManager(context)
          .getImageController()
          .uploadImage(imagePath);
      if (_image_url != null) {
        widget.user.profileUrl = _image_url;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => UploadPhotoSucess(
        //       user: widget.user,
        //     ),
        //   ),
        // );
      }
    } catch (e) {
      print('caught error $e');
    }
  }

  setBasicDetailsUpdate(Map<String, dynamic> formValues, BuildContext context) {
    // Setting formValues equal to user object values
    widget.user.username = formValues['Username'];
    widget.user.email = formValues['Email'];
    widget.user.password = formValues['Password'];
    widget.user.name = formValues["Name"];
    widget.user.gender = formValues["Gender"];
    widget.user.dob = formValues["DOB"].toString().split(" ").first;

    _setUpUser(context);
  }

  _setUpUser(BuildContext context) async {
    try {
      // // Result from logging in user could either be a error or user
      dynamic createdUser = await GeneralNetworkingMethodManager(context)
          .getUserController()
          .updateUser(widget.user);

      // Checking if the result is a error
      if (createdUser.runtimeType == InformationPopUp) {
        if (createdUser.message != null) {
          // Displaying error in pop up by setting the state
          setState(() {
            infoPopUp = createdUser;
          });
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (createdUser.username != null) {
          Navigator.pop(context, (route) => ProfilePage(user: createdUser));
        } else {
          infoPopUp.message =
              "An error occurred while registering. Please try again";
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  // Logic Functions

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getProfilePageBody());
  }

  // Retrieve Body
  getProfilePageBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 1080,
          padding: EdgeInsets.only(top: 40, left: 10),
          child: Column(
            children: [
              getTopButtonsBar(),
              getUpdateBasicDetailsProfile(),
              signUpButton(context),
            ],
          ),
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
                  Icon(Icons.arrow_back),
                ],
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 40,
        // ),
      ],
    );
  }

  getUpdateBasicDetailsProfile() {
    return Container(
      child: FormBuilder(
        key: _basicDetailsUpdateKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              if (widget.user.profileUrl != null)
                Container(
                  height: 150,
                  width: 200,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.user.profileUrl),
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
                        initialValue: widget?.user?.email,
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
                        initialValue: widget?.user.username,
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
                      Text("Password:"),
                      FormBuilderTextField(
                        initialValue: widget?.user?.password,
                        name: "Password",
                        obscureText: true,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(context),
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
                        initialValue: widget?.user?.name,
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
                        // initialValue: widget?.user?.gender != null
                        //     ? widget?.user?.gender
                        //     : "",
                        allowClear: true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: genderOptions
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

  // // Create the button to navigate to the basic details page
  // Widget createContinueToBasicDetailsPageBtn(BuildContext context) {
  //   return Container(
  //     width: 300,
  //     height: 60,
  //     child: ElevatedButton(
  //       style: ButtonProducer.getOrangeGymbudBtn(),
  //       onPressed: () {
  //         //Check if the form is validated
  //         if (_basicDetailsSignUpKey.currentState.saveAndValidate()) {
  //           setBasicDetailsUpdate(
  //             _basicDetailsSignUpKey.currentState.value,
  //             context,
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
  Widget signUpButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ElevatedButton(
        child: Text('Sign Up'),
        style: update_btn_style,
        onPressed: () => {
          // Check if the form is validated
          if (_basicDetailsUpdateKey.currentState.saveAndValidate())
            {
              // Setting the valid formValues equal to user object values
              setBasicDetailsUpdate(
                  _basicDetailsUpdateKey.currentState.value, context)
            }
        },
      ),
    );
  }
}

// import 'package:flutter_switch/flutter_switch.dart';
// bool isProfileSettings = false;
// FlutterSwitch(
//   activeText: "Profile",
//   inactiveText: "Activity Settings",
//   value: isProfileSettings,
//   valueFontSize: 10.0,
//   width: 410,
//   borderRadius: 30.0,
//   showOnOff: true,
//   onToggle: (val) {
//     setState(() {
//       isProfileSettings = val;
//     });
//   },
// ),
