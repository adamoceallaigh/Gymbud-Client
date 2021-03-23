// // Imports

// Library Imports

import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/General_Pages/Drawer_Stack_Screen.dart';
import 'package:Client/Presentation/General_Pages/Home_Stack_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Page Imports

class Home extends HookWidget {
  /*
    Setting up variables for this page
  */

  @override
  Widget build(BuildContext context) {
    // Setting the drawer back too normal if it's open
    // settingDrawerBackToNormalIfOpen(context);

    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      ),
    );
  }

  void settingDrawerBackToNormalIfOpen(BuildContext context) {
    context.read(drawer_change_provider).resetDrawer();
  }
}

// Setting up variables to make filter dropdown
// Widget filterWidget;
// bool isDropped = false;
// GlobalKey filterKey;
// double widthOfFilterContainer, heightOfContainer, xPos, yPos;
// OverlayEntry _filterContainer;

// Setting up variables for my filters
// RangeValues _ageValues = RangeValues(5, 90);

//   // Making the home page top bar
//   List<Widget> getTopBarActions() {
//     List<Widget> actionsList = [];
//     actionsList = [
//       GestureDetector(
//         onTap: () => {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProfilePage(user: widget.user),
//             ),
//           ),
//         },
//         child: CircleAvatar(
//           radius: 50.0,
//           backgroundImage: widget.user.profileUrl != null
//               ? new NetworkImage(widget.user.profileUrl)
//               : null,
//           backgroundColor: Colors.transparent,
//         ),
//       ),
//     ];
//     return actionsList;
//   }

//   // Creating the dropdown filter Widget
//   OverlayEntry _createDropDown() {
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: 0,
//         width: widthOfFilterContainer,
//         height: MediaQuery.of(context).size.height / 4,
//         top: yPos + heightOfContainer + 10,
//         child: Material(
//           child: Container(
//             alignment: null,
//             color: Colors.white,
//             height: 200,
//             child: Row(
//               children: [
//                 Container(
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset("Resources/Images/Male.svg"),
//                           SvgPicture.asset("Resources/Images/Female.svg"),
//                           SvgPicture.asset("Resources/Images/All_Gender.svg"),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           SvgPicture.asset("Resources/Images/GymWeights.svg"),
//                           SvgPicture.asset("Resources/Images/Home_Workout.svg"),
//                           SvgPicture.asset("Resources/Images/Outdoor_Act.svg"),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     children: [
//                       SliderTheme(
//                         data: SliderThemeData(
//                             showValueIndicator: ShowValueIndicator.always),
//                         child: RangeSlider(
//                           values: _ageValues,
//                           min: 0,
//                           max: 100,
//                           labels: RangeLabels('${_ageValues.start.round()}',
//                               '${_ageValues.end.round()}'),
//                           inactiveColor: Colors.grey,
//                           activeColor: HexColor('#EB9661'),
//                           onChanged: (RangeValues values) {
//                             print(
//                                 'START: ${_ageValues.start.round()}, END: ${_ageValues.end.round()}');
//                             setState(() {
//                               widget.user.preferredAgeRange =
//                                   '${_ageValues.start} - ${_ageValues.end}';
//                               _ageValues = values;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Creating the Top App bar
//   // Widget getAppBar() {
//   //   if (_currentIndex == 1) {
//   //     return AppBar(
//   //       title: GestureDetector(
//   //         key: filterKey,
//   //         onTap: () => {
//   //           setState(() {
//   //             if (isDropped)
//   //               _filterContainer.remove();
//   //             else {
//   //               fillDropDownData();
//   //               _filterContainer = _createDropDown();
//   //               Overlay.of(context).insert(_filterContainer);
//   //             }
//   //             isDropped = !isDropped;
//   //           })
//   //         },
//   //         child: Container(
//   //           margin: EdgeInsets.only(left: 4, right: 4),
//   //           height: 40,
//   //           decoration: BoxDecoration(
//   //             color: HexColor('#FFFFFF'),
//   //             border: Border.all(
//   //               width: 1.0,
//   //               color: HexColor('#C4C4C4'),
//   //             ),
//   //           ),
//   //           child: Row(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Text(
//   //                 "FILTER BY",
//   //                 textAlign: TextAlign.center,
//   //                 style: TextStyle(
//   //                   color: HexColor("#000000"),
//   //                 ),
//   //               ),
//   //               SizedBox(width: 10),
//   //               SvgPicture.asset("Resources/Images/arrowFilter.svg"),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       leading: Container(
//   //         height: 120,
//   //         padding: const EdgeInsets.all(0),
//   //         child: Row(
//   //           children: [
//   //             Expanded(
//   //               flex: 2,
//   //               child: Image.asset(
//   //                 'Resources/Images/logoGymbud.png',
//   //                 fit: BoxFit.fill,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //       // actions: getTopBarActions(),
//   //       backgroundColor: HexColor("FEFEFE"),
//   //     );
//   //   }
//   //   return AppBar(
//   //     leadingWidth: 100,
//   //     leading: Container(
//   //       child: Image.asset(
//   //         'Resources/Images/logoGymbud.png',
//   //       ),
//   //     ),
//   //     // actions: getTopBarActions(),
//   //     backgroundColor: HexColor("FEFEFE"),
//   //     iconTheme: IconThemeData(
//   //       color: HexColor("EB9661"),
//   //     ),
//   //   );
//   // }
// }

// filterKey = LabeledGlobalKey("filterDropdown");
// Filling the dropdown filter with data
// void fillDropDownData() {
//   RenderBox renderBox = filterKey.currentContext.findRenderObject();
//   widthOfFilterContainer = MediaQuery.of(context).size.width;
//   heightOfContainer = renderBox.size.height;
//   Offset offset = renderBox.localToGlobal(Offset.zero);
//   xPos = offset.dx;
//   yPos = offset.dy;
//   print(
//     "Height : $heightOfContainer , Width: $widthOfFilterContainer , xPos: $xPos , yPos: $yPos , isDropped: $isDropped",
//   );
// }
