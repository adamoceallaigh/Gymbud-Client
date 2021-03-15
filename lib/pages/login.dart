//Imports and Variable Declarations

// Library Imports
import 'package:Client/Helper_Widgets/GeneralNetworkingMethodManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

// Page Imports
import 'package:Client/Helper_Widgets/HexColor.dart';
import 'package:Client/Helper_Widgets/ButtonProducer.dart';
import 'package:Client/Controllers/UserController.dart';
import 'package:Client/Models/InformationPopUp.dart';
import 'package:Client/pages/Home.dart';
import 'package:Client/pages/New_User/BasicSignUp.dart';
import 'package:Client/Models/User.dart';

// Login Page
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// Template for what makes login page
class _LoginState extends State<Login> {
  /*  
    Setting up variables for this page
   */

  // Info  pop up to be used to alert user to a error within their input
  InformationPopUp infoPopUp = new InformationPopUp();

  // Basic sign up form key to be used for validation and on this page
  final _loginKey = GlobalKey<FormBuilderState>();

  // Styling for Signup Button
  final ButtonStyle login_btn_style = ButtonProducer.getOrangeGymbudBtn();

  // Logic Functions

  // Navigate to Home Page once validation passed
  _checkLoginValues(
      Map<String, dynamic> formValues, BuildContext context) async {
    // Setting up new instance of user controller
    UserController userController =
        GeneralNetworkingMethodManager(context).getUserController();

    try {
      // Result from logging in user could either be a error or boolean saying true
      dynamic userValidated = await userController.readSingleUser(
        formValues["Username"],
        formValues["Password"],
        context,
      );

      // Checking if the result is a error
      if (userValidated.runtimeType == InformationPopUp) {
        if (userValidated.message != null) {
          // Displaying error in pop up by setting the state
          setState(() {
            infoPopUp = userValidated;
          });
        }
      } else {
        // Navigating to the Home page if user logged in is returned
        if (userValidated.username != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(user: userValidated),
            ),
          );
        }
      }
    } catch (e) {
      print('caught error $e');
    }
  }

  // UI Functions

  @override
  Widget build(BuildContext context) {
    // Scaffold to make up the main part of the log in page
    return Scaffold(backgroundColor: Colors.white, body: retrieveLogInBody());
  }

  // Retrieve Body for the log in view
  Widget retrieveLogInBody() {
    return SingleChildScrollView(
      child: Container(
        height: 680,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildChildren(),
        ),
      ),
    );
  }

  // Building Template Widget to represent log in page body
  List<Widget> _buildChildren() {
    return [
      if (infoPopUp.message != null) checkForLoginErrorPopUp(),
      Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: 180,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Image.asset('Resources/Images/logoGymbud.png'),
      ),
      Text('Log into your account'),
      loginForm(context),
      loginButton(context),
      basicDetailsFormFooter(context),
    ];
  }

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
          Expanded(child: Text(infoPopUp.message)),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {
              setState(() {
                infoPopUp.message = null;
              })
            },
          ),
        ],
      ),
    );
  }

  // Building the Login Form
  Widget loginForm(BuildContext context) {
    return FormBuilder(
      key: _loginKey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10.0, top: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Username:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
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
                    child: Text("Password:",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  FormBuilderTextField(
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
          ],
        ),
      ),
    );
  }

  // Creating the login button and dealing with login button click
  Widget loginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ElevatedButton(
        child: Text('Login'),
        style: login_btn_style,
        onPressed: () => {
          // Check if the form is validated
          if (_loginKey.currentState.saveAndValidate())
            {
              // Checking the valid formValues against DB credentials
              _checkLoginValues(_loginKey.currentState.value, context)
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
          onTap: () {
            // Default user to use in the sign up process
            var newUser = User(
              resources: [],
              messages: [],
              buds: [],
              activities: [],
              activitiesEnjoyed: [],
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BasicSignUp(user: newUser),
              ),
            );
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
                  text: 'Don\'t have an account?',
                ),
                WidgetSpan(
                  child: Container(
                    width: 10,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
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
        Text('Forgot Your Password ?'),
      ],
    );
  }

  // End of the Login Page Functions
}
