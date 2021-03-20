// Imports

// Library Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Helpers/ButtonProducer.dart';

// Upload Profile Pic Page
class UploadPhoto extends StatefulWidget {
  /*  
    Setting up variables for this page
   */

  // User object to be required to transfer values across pages
  UploadPhoto({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  /*  
    Setting up variables for this page
   */

  // Styling for upload and take picture Buttons
  ButtonStyle upload_pic_btn_style = ButtonProducer.getOrangeGymbudBtn();

  // Image picker necessary for this page
  final picker = ImagePicker();

  // Logic Functions
  Future getImageFromSource(ImageSource imgSource, BuildContext context) async {
    final pickedImage = await picker.getImage(source: imgSource);

    if (pickedImage != null) {
      // dealWithUploadImageBtnClick(pickedImage.path, context: context);
    } else {
      print("No image selected");
    }
  }

  // dealWithUploadImageBtnClick(String imagePath,
  //     {BuildContext context = null}) async {
  //   try {
  //     // Image Url for image picked
  //     // String _image_url =
  //     //     await context.read(imageProvider).uploadImage(imagePath);
  //     // String _image_url = await GeneralNetworkingMethodManager(context)
  //     //     .getImageController()
  //     //     .uploadImage(imagePath);
  //     if (_image_url != null) {
  //       widget.user.profileUrl = _image_url;
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => UploadPhotoSucess(
  //             user: widget.user,
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print('caught error $e');
  //   }
  // }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 180,
          leading: Container(
            child: Image.asset(
              'Resources/Images/logoGymbud.png',
            ),
          ),
          backgroundColor: HexColor("FEFEFE"),
        ),
        backgroundColor: Colors.white,
        body: retreiveBody(context));
  }

  Widget retreiveBody(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 580,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Lets Get You Started",
                style: GoogleFonts.delius(
                  color: HexColor("#000000"),
                  fontSize: 24,
                  letterSpacing: -1.5,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: SvgPicture.asset(
                  'Resources/Images/Camera_Icon_Scan_Page.svg',
                ),
              ),
              Text(
                "Tap Button below please",
                style: GoogleFonts.meriendaOne(
                  color: HexColor("#000000"),
                  fontSize: 15,
                  // letterSpacing: -1.5,
                ),
              ),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      child: Text('Take Photo'),
                      style: upload_pic_btn_style,
                      onPressed: () => {
                        getImageFromSource(ImageSource.camera, context),
                      },
                    ),
                    ElevatedButton(
                      child: Text('Upload Photo'),
                      style: upload_pic_btn_style,
                      onPressed: () => {
                        getImageFromSource(ImageSource.gallery, context),
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
