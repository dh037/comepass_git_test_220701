
import 'package:flutter/material.dart';

class ShopInfoNotifier extends ChangeNotifier {

  String tabBarState = "이용권구매";
  int shopImagePageViewIndex = 0;

  bool heartIcon = false;

  mainTabBar (value) {
    tabBarState = value;
    notifyListeners();
  }

  shopImage (value) {
    shopImagePageViewIndex = value;
    notifyListeners();
  }

  toggleHeart () {
    heartIcon = !heartIcon;
    notifyListeners();
  }

}