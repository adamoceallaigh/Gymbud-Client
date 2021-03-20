import 'package:flutter/material.dart';

class DrawerChanger extends ChangeNotifier {
  // Variables to enable drawer to be shown
  double xOffset = 0;
  double yOffset = 0;

  // Variables to allow the scaling down of the drawer
  double scaleFactor = 1;

  // Boolean to indicate whether drawer is open or closed
  bool isDrawerOpen = false;

  slideOutDrawer() {
    xOffset = 230;
    yOffset = 150;
    scaleFactor = 0.6;
    isDrawerOpen = true;
    notifyListeners();
  }

  resetDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
    notifyListeners();
  }
}
