// Imports

// Library Imports
import 'package:Client/Presentation/User_Management/Read_User_Management/Read_User_Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports
import 'package:Client/Helpers/GeneralHelperMethodManager.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Helpers/HexColor.dart';
import 'package:Client/Config/configVariables.dart' as Constants;

class DrawerScreen extends HookWidget {
  // UI Functions

  @override
  Widget build(BuildContext context) {
    // Obtaining the drawer changer notifier provider for use here
    final drawer_changer = useProvider(drawer_change_provider);

    // Obtaining the current logged in user
    final logged_in_user = useProvider(user_notifier_provider.state);

    // Make new GeneralMethodsManager Instance
    final generalHelperMethodManager = GeneralHelperMethodManager(
        logged_in_user: logged_in_user, context: context);

    return Container(
      color: HexColor("EB9661"),
      padding: EdgeInsets.only(top: 40, left: 10, bottom: 85),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Widget to make the top part of the drawer
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: logged_in_user.profileUrl != null
                            ? new NetworkImage(logged_in_user.profileUrl)
                            : null,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          logged_in_user.name != null
                              ? Text(
                                  logged_in_user.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  child: Text(
                                      "There was a problem gathering your info. Try log in again"),
                                ),
                          Text(
                            'Active Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("eeeeee"),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => {drawer_changer.resetDrawer()},
                      child: Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                )
              ],
            ),
          ),

          // Widget to make the middle part of the drawer

          Column(
              children:
                  Constants.GeneralVariableStore.drawerItems.map((element) {
            return GestureDetector(
              onTap: () => {
                generalHelperMethodManager
                    .checkWhereToNavigateByNavBarItemClick(element["title"]),
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: element["type"] == null
                        ? Icon(
                            element["icon"],
                            color: Colors.white,
                            size: 30,
                          )
                        : element["icon"],
                  ),
                  Text(
                    element["title"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            );
          }).toList()),

          // Widget to make the footer of the drawer

          SafeArea(
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false)
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
