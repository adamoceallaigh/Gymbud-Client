// Imports

// Library Imports
import 'package:Client/Config/configVariables.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/GeneralComponents.dart';
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/User_Management/Create_User_Management/Create_User_Details_Page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Presentation/General_Pages/Home_Screen.dart';
import 'package:Client/Config/configVariables.dart' as Constants;

class AddActivity extends HookWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    /*
      Setting up our variables
    */

    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager = GeneralHelperMethodManager(
        logged_in_user: logged_in_user, context: context);

    var image_notifier = useProvider(image_notifier_provider);

    // Obtaining the activity we just set up
    final activity_notifier = useProvider(activity_notifier_provider.state);

    String getActivitySVG(String type) {
      if (type == null) return "Gymbud_Logo";
      var activityTypes = {
        "Home_Workout": "Home_Workout",
        "Gym_Workout": "GymWeights",
        "Outdoor_Activity": "Outdoor_Act"
      };
      return activityTypes[type];
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 3580,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 130,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              height: 90,
                              width: 93,
                              child: SvgPicture.asset(
                                'Resources/Images/Gymbud_Logo.svg',
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 10,
                            child: Container(
                              height: 70,
                              width: 73,
                              child: SvgPicture.asset(
                                "Resources/Images/${getActivitySVG(activity_notifier.activityType)}.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormBuilder(
                  key: _formKey,
                  child: Container(
                    height: 2770,
                    margin: EdgeInsets.all(10),
                    width: double.infinity - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type Of Activity",
                          style: GoogleFonts.meriendaOne(
                            color: HexColor("#000000"),
                            fontSize: 18,
                            letterSpacing: -1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            activity_notifier.activityType != null
                                ? activity_notifier.activityType
                                : "",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#7A7A7A"),
                              fontSize: 17,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            activity_notifier.activityType == "Gym_Workout" ||
                                    activity_notifier.activityType ==
                                        "Home_Workout"
                                ? "Name Of Workout"
                                : "Name Of Activity",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FormBuilderTextField(
                            name: 'Activity_Name',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            activity_notifier.activityType == "Gym_Workout" ||
                                    activity_notifier.activityType ==
                                        "Home_Workout"
                                ? "Description Of Workout"
                                : "Description of Activity",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FormBuilderTextField(
                            maxLines: 10,
                            name: 'Activity_Description',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 52.0),
                          child: Column(
                            children: [
                              Text(
                                activity_notifier.activityType ==
                                            "Gym_Workout" ||
                                        activity_notifier.activityType ==
                                            "Home_Workout"
                                    ? "Looking to Workout With"
                                    : "Activity Gender Preference",
                                style: GoogleFonts.meriendaOne(
                                  color: HexColor("#000000"),
                                  fontSize: 18,
                                  letterSpacing: -1.5,
                                ),
                              ),
                              SelectFromOptionsWidget(
                                generalOptions: Constants
                                    .ActivityVariableStore.mainGenderOptions,
                                placeToChangeFrom: "Activity",
                                whatToChange: "Gender",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Date Time Picker",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FormBuilderDateTimePicker(
                            name: 'Activity_Date_Time',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context),
                              ],
                            ),
                          ),
                        ),
                        ActivitySliders(context: context, place: "Activity"),
                        if (activity_notifier.activityType == "Home_Workout")
                          ActivityResourcesGrid(
                              context: context, place: "Activity"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity duration",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: Column(
                            children: [
                              Text("Pick the amount of hours"),
                              FormBuilderSegmentedControl(
                                padding: EdgeInsets.all(20),
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                  ],
                                ),
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                options: List.generate(5, (index) => index + 1)
                                    .map(
                                      (number) => FormBuilderFieldOption(
                                        value: number,
                                      ),
                                    )
                                    .toList(),
                                name: 'Activity_Duration_Hours',
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text("Pick the amount of minnutes"),
                              FormBuilderTextField(
                                name: 'Activity_Duration_Minutes',
                                maxLength: 2,
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.integer(context),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity location",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Pick the activity Image",
                            style: GoogleFonts.meriendaOne(
                              color: HexColor("#000000"),
                              fontSize: 18,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: 300,
                            height: 330,
                            color: Colors.black12,
                            child: image_notifier.value == null ||
                                    image_notifier.value == ""
                                ? Text("No image Selected")
                                : Image.network(
                                    image_notifier.value.toString(),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: image_notifier.value != null
                                  ? Text(
                                      "No image Selected. Please pick one to continue")
                                  : Text(
                                      "That’s Perfect 👌 \n On We GO!!",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.meriendaOne(
                                        color: HexColor("#000000"),
                                        fontSize: 15,
                                        // letterSpacing: -1.5,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: StyleVariableStore.upload_pic_btn_style,
                                onPressed: () async {
                                  String imageUrl =
                                      await generalHelperMethodManager
                                          .getImageFromSource(
                                              ImageSource.camera,
                                              place: "Activity");
                                  image_notifier.setString(imageUrl);
                                  print(imageUrl);
                                },
                                child: Icon(Icons.camera, color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                style: StyleVariableStore.upload_pic_btn_style,
                                onPressed: () async {
                                  String imageUrl =
                                      await generalHelperMethodManager
                                          .getImageFromSource(
                                              ImageSource.gallery,
                                              place: "Activity");
                                  image_notifier.setString(imageUrl);
                                },
                                child: Icon(Icons.folder, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        if (image_notifier.value != null)
                          CreateActivityBtn(_formKey)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateActivityBtn extends HookWidget {
  final GlobalKey<FormBuilderState> formKey;
  CreateActivityBtn(this.formKey);

  @override
  Widget build(BuildContext context) {
    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager = GeneralHelperMethodManager(
        logged_in_user: logged_in_user, context: context);

    // Obtaining the activity we just set up
    final activity_notifier = useProvider(activity_notifier_provider.state);

    void setUpActivity(
        Map<String, dynamic> formValues, BuildContext context) async {
      final formattedDate = DateFormat('yyyy-MM-dd kk:mm')
          .format(formValues['Activity_Date_Time']);
      activity_notifier.activityName = formValues['Activity_Name'];
      activity_notifier.activityDescription =
          formValues['Activity_Description'];
      activity_notifier.date = formattedDate.split(" ")[0];
      activity_notifier.time = formattedDate.split(" ")[1];
      activity_notifier.activityIntensityLevel =
          context.read(activity_notifier_provider.state).activityIntensityLevel;
      activity_notifier.duration =
          '${formValues['Activity_Duration_Hours']} hours ${formValues['Activity_Duration_Minutes']} minutes';
      activity_notifier.creator = logged_in_user;
      activity_notifier.participants = [logged_in_user];
      activity_notifier.activityBudgetLevel =
          context.read(activity_notifier_provider.state).activityBudgetLevel;
      activity_notifier.activityFitnessLevel =
          context.read(activity_notifier_provider.state).activityFitnessLevel;
      activity_notifier.activityImageUrl =
          context.read(image_notifier_provider).value;
      activity_notifier.resources =
          context.read(activity_notifier_provider.state).resources;
      activity_notifier.location = "4 Fraher Field, WestPort";

      // Creating a Activity
      dynamic isCreatedActivity = await context
          .read(activities_provider)
          .createactivity(activity_notifier);
      // if (isCreatedActivity == null) //TODO: Implement Error Pop Up
      if (isCreatedActivity == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          width: 300,
          height: 60,
          child: ElevatedButton(
            style: ButtonProducer.getOrangeGymbudBtn(),
            onPressed: () {
              if (formKey.currentState.saveAndValidate()) {
                setUpActivity(
                  formKey.currentState.value,
                  context,
                );
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Create",
                style: GoogleFonts.concertOne(
                  fontSize: 30,
                  // letterSpacing: -1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Future getImageFromSource(ImageSource imgSource) async {
//   final pickedImage = await picker.getImage(source: imgSource);

//   if (pickedImage != null) {
//     setState(() {
//       _image = File(pickedImage.path);
//     });
//   } else {
//     print("No image selected");
//   }

//   try {
//     String filename = pickedImage.path.split("/").last;
//     final mimeTypeData =
//         lookupMimeType(_image.path, headerBytes: [0xFF, 0xD8]).split("/");

//     FormData formData = new FormData.fromMap({
//       'uploadingImage': await MultipartFile.fromFile(
//         _image.path,
//         filename: filename,
//         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
//       ),
//       "type": "image/png"
//     });

//     // var url_sim = 'http://10.0.2.2:7000/image/upload';
//     // var urlConstants.dev = 'https://gymbud.herokuapp.com/image/upload';
//     Response response = await dio.post(urlConstants.dev,
//         data: formData,
//         options: Options(headers: {
//           "accept": "*/*",
//           "Content-Type": "multipart/form-data"
//         }));

//     print(response);
//     var imageJSON;
//     if (response.statusCode == 200) {
//       imageJSON = response.data;
//       widget.activity.activityImageUrl = ImageURL.fromJson(imageJSON).path;
//     }
//   } catch (e) {
//     print(e);
//   }
// }
