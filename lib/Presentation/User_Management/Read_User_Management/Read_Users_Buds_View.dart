// Imports

// Library Imports
import 'package:Client/Managers/Providers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Config/configVariables.dart' as Constants;
import 'package:Client/Presentation/Activity_Management/Read_Activity_Management/Read_Activities_Match_View.dart';

// Template to make the Buds View Page
class BudsView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /*
      Setting up variables for this page
    */

    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            // Widget to make the appBar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: Constants.shadowList,
                                ),
                                // margin: EdgeInsets.only(top: 10),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    "Resources/Images/Gymbud_Logo.svg",
                                    height: 60,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: logged_in_user?.profileUrl != null
                        ? new NetworkImage(logged_in_user.profileUrl)
                        : null,
                    // backgroundColor: Colors.orange,
                  ),
                ],
              ),
            ),

            // Widget to make the search bar row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search for a bud here...'),
                  Icon(Icons.settings),
                ],
              ),
            ),

            // Widget to make the horizontal scroll view
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: Constants.shadowList,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            "Resources/Images/GymWeights.svg",
                            height: 50,
                            width: 50,
                            color: Colors.grey[700],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          child: Text("GymWeights"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Widget to make the rows for the conversations
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Buds".toUpperCase(),
                    style: GoogleFonts.delius(
                      color: HexColor("EB9661"),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Expanded(
                    child: Container(
                      height: 40,
                      color: HexColor("EB9661"),
                      child: ElevatedButton(
                        child: Text("Find Some Buds"),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchView(),
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
