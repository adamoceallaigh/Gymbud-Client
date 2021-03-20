// import 'dart:io';
// import 'package:Client/Controllers/ActivityController.dart';
// import 'package:Client/Helper_Widgets/GeneralNetworkingMethodManager.dart';
// import 'package:Client/Helper_Widgets/HexColor.dart';
// import 'package:Client/Infrastructure/Models/ImageURL.dart';
// import 'package:Client/Infrastructure/Models/Activity.dart';
// import 'package:Client/Infrastructure/Models/User.dart';
// import 'package:Client/pages/Home.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart';

// class AddActivity extends StatefulWidget {
//   final User user;
//   final Activity activity;
//   AddActivity({Key key, this.user, this.activity}) : super(key: key);

//   @override
//   _AddActivityState createState() => _AddActivityState();
// }

// class _AddActivityState extends State<AddActivity> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   final genderOptions = ["Male", "Female", "No Preference"];
//   double _defaultIntensity = 20.0;
//   double _defaultActivityLevel = 20.0;
//   double _defaultBudgetLevel = 10.0;
//   Uri urlLocal = Uri.parse('http://10.0.2.2:7000/image/upload');
//   File _image;
//   final picker = ImagePicker();
//   Dio dio = new Dio();

//   final resources = [
//     "Bicycle",
//     "Assault Bike",
//     "Trap Bar",
//     "Barbells",
//     "Plates",
//     "Bands",
//     "Suspension Trainers",
//     "Skipping Rope",
//     "Treadmill",
//     "Slam Ball",
//     "Kettle Bells"
//   ];

//   Future getImageFromSource(ImageSource imgSource) async {
//     final pickedImage = await picker.getImage(source: imgSource);

//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     } else {
//       print("No image selected");
//     }

//     try {
//       String filename = pickedImage.path.split("/").last;
//       final mimeTypeData =
//           lookupMimeType(_image.path, headerBytes: [0xFF, 0xD8]).split("/");

//       FormData formData = new FormData.fromMap({
//         'uploadingImage': await MultipartFile.fromFile(
//           _image.path,
//           filename: filename,
//           contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
//         ),
//         "type": "image/png"
//       });

//       // var url_sim = 'http://10.0.2.2:7000/image/upload';
//       // var url_dev = 'https://gymbud.herokuapp.com/image/upload';
//       Response response = await dio.post(url_dev,
//           data: formData,
//           options: Options(headers: {
//             "accept": "*/*",
//             "Content-Type": "multipart/form-data"
//           }));

//       print(response);
//       var imageJSON;
//       if (response.statusCode == 200) {
//         imageJSON = response.data;
//         widget.activity.activityImageUrl = ImageURL.fromJson(imageJSON).path;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   String getActivitySVG(String type) {
//     var activityTypes = {
//       "Home Workout": "Home_Workout",
//       "Gym Workout": "GymWeights",
//       "Outdoor Activity": "Outdoor_Act"
//     };
//     return activityTypes[type];
//   }

//   void setUpActivity(
//       Map<String, dynamic> formValues, BuildContext context) async {
//     final formattedDate =
//         DateFormat('yyyy-MM-dd kk:mm').format(formValues['Activity_Date_Time']);
//     // ['id'] = widget.user._id;
//     widget.activity.activityName = formValues['Workout_Name'];
//     widget.activity.activityDescription = formValues['Workout_Description'];
//     widget.activity.activityGenderPreference = formValues['Gender_Preference'];
//     widget.activity.date = formattedDate.split(" ")[0];
//     widget.activity.time = formattedDate.split(" ")[1];
//     widget.activity.activityIntensityLevel =
//         getLabel(formValues['Activity_Intensity_Level'], "Intensity");
//     widget.activity.duration = formValues['Activity_Duration'];
//     widget.activity.creator = widget.user;
//     widget.activity.participants = [widget.user];
//     widget.activity.activityBudgetLevel =
//         getLabel(formValues['Activity_Budget_Level'], "Budget");
//     widget.activity.activityFitnessLevel =
//         getLabel(formValues['Activity_Fitness_Level'], "Fitness");
//     widget.activity.location = "4 Fraher Field, WestPort";

//     // Creating a Activity
//     ActivityController activity_controller =
//         GeneralNetworkingMethodManager(context).getActivityController();
//     bool isCreated = await activity_controller.createactivity(widget.activity);
//     if (isCreated == true)
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Home(
//             user: widget.user,
//           ),
//         ),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             height: 3520,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       height: 130,
//                       width: MediaQuery.of(context).size.width - 20,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             top: 20,
//                             left: 10,
//                             child: Container(
//                               height: 90,
//                               width: 93,
//                               child: SvgPicture.asset(
//                                 'Resources/Images/Gymbud_Logo.svg',
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 20,
//                             right: 10,
//                             child: Container(
//                               height: 70,
//                               width: 73,
//                               child: SvgPicture.asset(
//                                 "Resources/Images/${getActivitySVG(widget.activity.activityType)}.svg",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 FormBuilder(
//                   key: _formKey,
//                   child: Container(
//                     height: 2570,
//                     margin: EdgeInsets.all(10),
//                     width: double.infinity - 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Type Of Activity",
//                           style: GoogleFonts.meriendaOne(
//                             color: HexColor("#000000"),
//                             fontSize: 18,
//                             letterSpacing: -1.5,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10.0),
//                           child: Text(
//                             widget.activity.activityType,
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#7A7A7A"),
//                               fontSize: 17,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Name Of Workout",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: FormBuilderTextField(
//                             name: 'Workout_Name',
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Description Of Workout",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: FormBuilderTextField(
//                             name: 'Workout_Description',
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text(
//                             "Looking to Workout With",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Wrap(
//                                 direction: Axis.vertical,
//                                 children: [
//                                   SvgPicture.asset("Resources/Images/Male.svg"),
//                                   Text("Male")
//                                 ],
//                               ),
//                               Wrap(
//                                 direction: Axis.vertical,
//                                 children: [
//                                   SvgPicture.asset(
//                                       "Resources/Images/Female.svg"),
//                                   Text("Female")
//                                 ],
//                               ),
//                               Wrap(
//                                 direction: Axis.vertical,
//                                 children: [
//                                   SvgPicture.asset(
//                                       "Resources/Images/All_Gender.svg"),
//                                   Text("No Preference")
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 150,
//                                 child: FormBuilderRadioGroup(
//                                   name: 'Gender_Preference',
//                                   options: genderOptions
//                                       .map(
//                                         (lang) => FormBuilderFieldOption(
//                                           value: lang,
//                                           child: Text(''),
//                                         ),
//                                       )
//                                       .toList(growable: false),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text(
//                             "Date Time Picker",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: FormBuilderDateTimePicker(
//                             name: 'Activity_Date_Time',
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: Text(
//                             "Pick your Activity Fitness Level",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: FormBuilderSlider(
//                             name: 'Activity_Fitness_Level',
//                             max: 100.0,
//                             min: 0.0,
//                             divisions: 5,
//                             activeColor: HexColor("#EB9661"),
//                             label: getLabel(_defaultActivityLevel, "Fitness"),
//                             initialValue: _defaultActivityLevel,
//                             onChanged: (val) => {
//                               // widget.activity.
//                               setState(() {
//                                 _defaultActivityLevel = val;
//                               })
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: Text(
//                             "Pick your Activity Intensity Level",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: FormBuilderSlider(
//                             name: 'Activity_Intensity_Level',
//                             max: 100.0,
//                             min: 0.0,
//                             divisions: 5,
//                             activeColor: HexColor("#EB9661"),
//                             label: getLabel(_defaultIntensity, "Intensity"),
//                             initialValue: _defaultIntensity,
//                             onChanged: (val) => {
//                               widget.activity.activityIntensityLevel =
//                                   getLabel(_defaultIntensity, "Intensity"),
//                               setState(() {
//                                 _defaultIntensity = val;
//                               })
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: Text(
//                             "Pick your Activity Budget Level",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: FormBuilderSlider(
//                             name: 'Activity_Budget_Level',
//                             max: 100.0,
//                             min: 0.0,
//                             divisions: 5,
//                             activeColor: HexColor("#EB9661"),
//                             label: getLabel(_defaultBudgetLevel, "Budget"),
//                             initialValue: _defaultBudgetLevel,
//                             onChanged: (val) => {
//                               // widget.sess
//                               setState(() {
//                                 _defaultBudgetLevel = val;
//                               })
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Pick the resources you have",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 25.0),
//                           child: SizedBox(
//                             height: 200,
//                             child: GridView.count(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 padding: const EdgeInsets.all(10.0),
//                                 crossAxisCount: 4,
//                                 mainAxisSpacing: 20.0,
//                                 crossAxisSpacing: 20.0,
//                                 shrinkWrap: true,
//                                 children: resources.map((resource) {
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: HexColor('#C8C8C8'))),
//                                     child: FlatButton(
//                                       child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               resource,
//                                               style: TextStyle(fontSize: 11.0),
//                                             )
//                                           ]),
//                                       color: widget.user.resources
//                                               .contains(resource)
//                                           ? HexColor('#EB9661')
//                                           : Colors.transparent,
//                                       onPressed: () => {
//                                         if (!widget.user.resources
//                                             .contains(resource))
//                                           {widget.user.resources.add(resource)}
//                                         else
//                                           {
//                                             widget.user.resources
//                                                 .remove(resource)
//                                           },
//                                         setState(() => {})
//                                       },
//                                     ),
//                                   );
//                                 }).toList()),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Pick the activity duration",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: FormBuilderTextField(
//                             name: 'Activity_Duration',
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Pick the activity location",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Container(
//                             color: Colors.blue,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Text(
//                             "Pick the activity Image",
//                             style: GoogleFonts.meriendaOne(
//                               color: HexColor("#000000"),
//                               fontSize: 18,
//                               letterSpacing: -1.5,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 200.0,
//                             child: Center(
//                                 child: _image == null
//                                     ? Text("No image Selected")
//                                     : Image.file(_image)),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             RaisedButton(
//                               onPressed: () =>
//                                   getImageFromSource(ImageSource.camera),
//                               child: Icon(Icons.camera),
//                             ),
//                             RaisedButton(
//                               onPressed: () =>
//                                   getImageFromSource(ImageSource.gallery),
//                               child: Icon(Icons.folder),
//                             )
//                           ],
//                         ),
//                         Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: RaisedButton(
//                               color: HexColor("#FFFFFF"),
//                               onPressed: () => {
//                                 if (_formKey.currentState.saveAndValidate())
//                                   {
//                                     setUpActivity(
//                                       _formKey.currentState.value,
//                                       context,
//                                     ),
//                                   }
//                               },
//                               child: Text(
//                                 "Create",
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String getLabel(double percLevel, String mode) {
//     var modes = {
//       "Fitness": {
//         0: "Inactive",
//         20: "Slightly Active",
//         40: "Moderately Active",
//         60: "Active",
//         80: "Very Active",
//         100: "Super Active"
//       },
//       "Intensity": {
//         0: "Not Intensive",
//         20: "Slightly Intensive",
//         40: "Moderately Intensive",
//         60: "Intensive",
//         80: "Very Intensive",
//         100: "Super Intensive"
//       },
//       "Budget": {
//         0: "Free",
//         20: "Slightly Expensive",
//         40: "Moderately Expensive",
//         60: "Expensive",
//         80: "Very Expensive",
//         100: "Super Expensive"
//       }
//     };
//     return modes[mode][percLevel];
//   }
// }
