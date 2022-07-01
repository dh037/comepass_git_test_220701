import 'dart:convert';

import 'package:comepass/data/model/member_regist.dart';
import 'package:comepass/data/regex.dart';
import 'package:flutter/material.dart';

import '../../constants/routes_path.dart';

class RegisterIdPwdNotifier extends ChangeNotifier {
  late MemberRegist memberRegist;

  var idTextFieldController = TextEditingController();
  bool idInputString = false;
  bool id5orMore = false;
  bool id12ofLess = false;

  var pwdTextFieldController = TextEditingController();
  bool pwdInputString = false;
  bool pwd8orMore = false;
  bool pwd20ofLess = false;

  var pwdConfirmTextFieldController = TextEditingController();
  bool pwdConfirmCheck = false;

  idValidation(String value) {
    idInputString = false;
    id5orMore = false;
    id12ofLess = false;

    if (Regex.idRule().hasMatch(value)) {
      idInputString = true;
      notifyListeners();
    }

    if (value.length > 5) {
      id5orMore = true;
      notifyListeners();
    }

    if (value.length < 20 && value.length > 5) {
      id12ofLess = true;
      notifyListeners();
    }

    notifyListeners();
  }

  pwdValidation(String value) {
    pwdInputString = false;
    pwd8orMore = false;
    pwd20ofLess = false;
    pwdConfirmCheck = false;
    if (Regex.passwordRule().hasMatch(value)) {
      pwdInputString = true;
      notifyListeners();
    }

    if (value.length >= 8) {
      pwd8orMore = true;
      notifyListeners();
    }

    if (value.length <= 20 && value.length >= 8) {
      pwd20ofLess = true;
      notifyListeners();
    }

    if (value == pwdConfirmTextFieldController.text && value.isNotEmpty) {
      pwdConfirmCheck = true;
      notifyListeners();
    }

    notifyListeners();
  }

  pwdConfirmValidation(String value) {
    pwdConfirmCheck = false;
    if (value == pwdTextFieldController.text) {
      pwdConfirmCheck = true;
      notifyListeners();
    }
    notifyListeners();
  }

  bool finalValidation() {
    if (idInputString &&
        id5orMore &&
        id12ofLess &&
        pwdInputString &&
        pwd8orMore &&
        pwd20ofLess &&
        pwdConfirmCheck) {
      return true;
    } else {
      return false;
    }
  }

  pressNextBtn(BuildContext context) {
    memberRegist.userId = idTextFieldController.text;
    memberRegist.userPw = pwdTextFieldController.text;

    Navigator.pushNamed(context, RoutePath.registerInfoPage, arguments: memberRegist);
  }

}
