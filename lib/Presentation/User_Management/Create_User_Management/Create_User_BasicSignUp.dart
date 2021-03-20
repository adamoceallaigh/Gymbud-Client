// Imports and Variable Declarations

// Library Import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Page Imports
import 'package:Client/Infrastructure/Models/User.dart';
import 'package:Client/Helpers/ButtonProducer.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Presentation/User_Management/Create_User_Management/Create_User_Upload_Photo.dart';
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Login.dart';

// Sign Up Page
class BasicSignUp extends StatelessWidget {
  /*  
    Setting up variables for this page
   */

  // User object to be required to transfer values across pages
  final User user;
  BasicSignUp({Key key, @required this.user}) : super(key: key);

  // Basic sign up form key to be used for validation and on this page
  final _basicSignUpKey = GlobalKey<FormBuilderState>();

  // Styling for Signup Button
  final ButtonStyle sign_up_btn_style = ButtonProducer.getOrangeGymbudBtn();

  // Logic Functions

  setBasicDetailsSignUp(Map<String, dynamic> formValues, BuildContext context) {
    // Setting formValues equal to user object values
    user.username = formValues['Username'];
    user.email = formValues['Email'];
    user.password = formValues['Password'];

    //Navigating to the Details Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPhoto(user: user),
      ),
    );
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    // Scaffold to make up the main part of the sign up page
    return Scaffold(
      backgroundColor: Colors.white,
      body: retrieveBody(context),
    );
  }

  // Retrieve Body for the Sign Up view
  Widget retrieveBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 880,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Image.asset('Resources/Images/logoGymbud.png'),
              ),
              Text('Register your account below'),
              signUpForm(context),
              signUpButton(context),
              basicDetailsFormFooter(context)
            ],
          ),
        ),
      ),
    );
  }

  // Building the Sign up form
  Widget signUpForm(BuildContext context) {
    return FormBuilder(
      key: _basicSignUpKey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  FormBuilderTextField(
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
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Username:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  FormBuilderTextField(
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
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    name: "Password",
                    obscureText: true,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.minLength(context, 8)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creating the Sign Up Button and dealing with signing up first part
  Widget signUpButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ElevatedButton(
        child: Text('Sign Up'),
        style: sign_up_btn_style,
        onPressed: () => {
          // Check if the form is validated
          if (_basicSignUpKey.currentState.saveAndValidate())
            {
              // Setting the valid formValues equal to user object values
              setBasicDetailsSignUp(_basicSignUpKey.currentState.value, context)
            }
        },
      ),
    );
  }

  // Building the Footer for Sign Up form
  Widget basicDetailsFormFooter(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            )
          },
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.meriendaOne(
                color: HexColor("#000000"),
                fontSize: 15,
                letterSpacing: -1.5,
              ),
              children: [
                TextSpan(
                  text: 'Have an account?',
                ),
                WidgetSpan(
                  child: Container(
                    width: 10,
                  ),
                ),
                TextSpan(
                  text: 'Log In',
                  style: TextStyle(
                    color: HexColor("EB9661"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 30,
        ),
        GestureDetector(
          onTap: () => {null},
          child: Text('Forgot Your Password ?'),
        )
      ],
    );
  }

  // End of the Sign Up Page Functions
}
