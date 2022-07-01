
import 'dart:convert';

import 'package:comepass/data/model/member_regist.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/routes_path.dart';

class RegisterInfoNotifier extends ChangeNotifier {
  late MemberRegist memberRegist;

  var nameTextFieldController = TextEditingController();
  bool nameState = false;
  nameValidator(state) {
    nameState = state;
    notifyListeners();
  }

  var birthTextFieldController = TextEditingController();
  bool birthState = false;
  birthValidator(state) {
    birthState = state;
    notifyListeners();
  }

  var emailTextFieldController = TextEditingController();
  bool emailState = false;
  emailValidator(state) {
    emailState = state;
    notifyListeners();
  }

  // true 남자, false 여자
  bool? gender;

  onTapManRadioBtn() {
    gender = true;
    notifyListeners();
  }

  onTapWomenRadioBtn() {
    gender = false;
    notifyListeners();
  }

  bool parentalConsent = false;

  onTapParentalConsent () {
    parentalConsent = !parentalConsent;
    if (!parentalConsent) parentPhoneTextFieldController.text = "";
    notifyListeners();
  }

  var parentPhoneTextFieldController = TextEditingController();


  pressNextBtn(BuildContext context) {

    memberRegist.userNm = nameTextFieldController.text;
    memberRegist.userBirth = birthTextFieldController.text.replaceAll(" ", "");
    memberRegist.userEmail = emailTextFieldController.text;
    if (gender != null) memberRegist.userGender = gender! ? 'M' : 'F';

    memberRegist.alrams!.optional!.removeWhere((item) => item == 2);

    if (parentalConsent) memberRegist.alrams!.optional!.add(2);


    parentalConsent ? memberRegist.parentAlarm = "Y" : memberRegist.parentAlarm = "N";

    parentalConsent ? memberRegist.parentPhone = parentPhoneTextFieldController.text : memberRegist.parentPhone = null;
    //
    // print(parentalConsent);
    // print(memberRegist.parentPhone);
    Navigator.pushNamed(context, RoutePath.registerKioskPage, arguments: memberRegist);
  }

}