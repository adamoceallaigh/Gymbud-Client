// Imports

// Library Imports
import 'package:Client/Presentation/User_Management/Create_User_Management/Create_User_Details_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Page Imports
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Infrastructure/Models/User.dart';

// Upload Profile Pic Success Page
class UploadPhotoSucess extends StatefulWidget {
  /*  
    Setting up variables for this page
   */

  // User object to be required to transfer values across pages
  final User user;
  UploadPhotoSucess({Key key, this.user}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhotoSucess> {
  /*  
    Setting up variables for this page
   */

  // Logic Functions

  // UI Functions

  @override
  Widget build(BuildContext context) {
    // Scaffold to make up the main part of the upload profile pic page
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
      body: retrieveBody(),
    );
  }

  Widget retrieveBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 630,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 240,
                      height: 240,
                      padding: widget?.user?.profileUrl == null
                          ? EdgeInsets.all(5)
                          : null,
                      color: Colors.black12,
                      child: widget?.user?.profileUrl == null
                          ? Icon(Icons.add)
                          : Image.network(
                              widget?.user?.profileUrl,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: widget?.user?.profileUrl == null
                      ? Text("No image Selected. Please pick one to continue")
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
              if (widget?.user?.profileUrl != null)
                createContinueToBasicDetailsPageBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  // Create the button to navigate to the basic details page
  Widget createContinueToBasicDetailsPageBtn(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ButtonProducer.getOrangeGymbudBtn(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                user: widget.user,
              ),
            ),
          );
        },
        child: Text(
          "Continue",
          style: GoogleFonts.delius(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
