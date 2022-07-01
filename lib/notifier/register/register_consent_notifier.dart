import 'dart:convert';

import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/model/member_regist.dart';
import 'package:flutter/material.dart';

import '../../constants/icon_path.dart';

class RegisterConsentNotifier extends ChangeNotifier {

  MemberRegist memberRegist = MemberRegist();
  Alrams alrams = Alrams();

  // 전체동의
  bool allCheck = false;

  // 서비스 이용약관
  bool serviceCheck = false;
  // 개인정보 수집 및 이용
  bool infoCheck = false;
  // 광고성 문자 수신 여부
  bool adCheck = false;

  onTabAllCheck () {
    allCheck = !allCheck;
    serviceCheck = false;
    infoCheck = false;
    adCheck = false;

    if (allCheck) {
      serviceCheck = true;
      infoCheck = true;
      adCheck = true;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  allCheckValidation () {
    if (serviceCheck && infoCheck && adCheck) {
      allCheck = true;
      notifyListeners();
    } else {
      allCheck = false;
      notifyListeners();
    }
  }

  void pressConfirmBtn (BuildContext context) {

    // 필수 동의 : 서비스 1 개인정보 2
    // 선택 동의 : 광고 1 부모님 2

    alrams.required = [];
    alrams.optional = [];

    if (serviceCheck) alrams.required!.add(1);
    if (infoCheck) alrams.required!.add(2);
    if (adCheck) alrams.optional!.add(1);

    memberRegist.alrams = alrams;

    Navigator.pushNamed(context, RoutePath.registerCertificationPage,arguments: memberRegist);
  }

  // view 단에서 하기 위해서?...
  notifyListener() {
    notifyListeners();
  }



}

