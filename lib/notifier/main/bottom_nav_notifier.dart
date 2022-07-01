
import 'package:flutter/material.dart';

class BottomNavNotifier extends ChangeNotifier {

  GlobalKey<NavigatorState> setting = GlobalKey<NavigatorState>();

  int bottomNavCurrentIndex = 0;
  bottomNav(value) {
    if (value == 2) {
      return;
    }else {
      bottomNavCurrentIndex = value;
      notifyListeners();
    }
  }



}