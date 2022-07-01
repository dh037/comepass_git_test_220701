import 'dart:convert';

import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/model/member_regist.dart';
import 'package:comepass/data/remote/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class SsoRegisterNotifier extends ChangeNotifier {

  late Map<String, dynamic> userData;
  RestApi restApi = RestApi();

  var kioskTextFieldController = TextEditingController();
  bool kioskState = false;

  kioskValidator(String? value) {
    kioskState = true;
    if (value!.length < 4) {
      kioskState = false;
    }
    notifyListeners();
  }

  bool parentalConsent = false;

  onTapParentalConsent() {
    parentalConsent = !parentalConsent;
    notifyListeners();
  }

  var parentPhoneTextFieldController = TextEditingController();
  bool parentPhoneState = false;

  parentPhoneValidator(String? value) {
    parentPhoneState = true;
    if (value!.length < 11) {
      parentPhoneState = false;
    }
    notifyListeners();
  }


  bool serviceCheck = false;
  onTapServiceCheckBox() {
    serviceCheck = !serviceCheck;
    notifyListeners();
  }

  bool infoCheck = false;

  onTapInfoCheckBox() {
    infoCheck = !infoCheck;
    notifyListeners();
  }

  bool adCheck = false;

  onTapAdCheckBox() {
    adCheck = !adCheck;
    notifyListeners();
  }

  pressRegisterBtn(BuildContext context) async {
    MemberRegist memberRegist = MemberRegist();
    Alrams alrams = Alrams();

    alrams.required = [];
    alrams.optional = [];

    if (serviceCheck) alrams.required!.add(1);
    if (infoCheck) alrams.required!.add(2);
    if (adCheck) alrams.optional!.add(1);
    if (parentalConsent) alrams.optional!.add(2);

    memberRegist.alrams = alrams;
    if (userData['platform'] == "kakao") {
      User kakaoUser = userData['data'] as User;


      // 임시방편
      kakaoUser.kakaoAccount?.name == null
          ? memberRegist.userNm = kakaoUser.kakaoAccount?.profile?.nickname
          : memberRegist.userNm = kakaoUser.kakaoAccount?.name;
      kakaoUser.kakaoAccount!.phoneNumber != null
          ? memberRegist.userPhone = '0${kakaoUser.kakaoAccount?.phoneNumber.toString().substring(4, 16)}'
          : memberRegist.userPhone = '010-0000-0000';
      //

      memberRegist.userEmail = kakaoUser.kakaoAccount?.email;
      memberRegist.userBirth =
      '${kakaoUser.kakaoAccount?.birthyear}${kakaoUser.kakaoAccount?.birthday}';
      memberRegist.userGender =
      kakaoUser.kakaoAccount?.gender == Gender.male ? "M" : "F";
      memberRegist.pinCode = kioskTextFieldController.text;
      memberRegist.platform = "K";
      memberRegist.platformId = kakaoUser.id.toString();
      memberRegist.parentPhone = parentPhoneTextFieldController.text;
      memberRegist.parentAlarm = parentalConsent ? 'Y' : "N";

      Response response = await restApi.register(memberRegist);
      var httpCode = response.statusCode;

      print('======== pressRegisterBtn() kakao! =======');
      print('status code : $httpCode');

      if (httpCode == 201) {
        print('======== pressRegisterBtn() kakao!  httpCode = 201! =======');
        print('회원가입 성공 회성공 페이지로 이동');
        Navigator.pushNamed(context, RoutePath.registerSuccessPage);
      } else {
        print('======== pressRegisterBtn() kakao!  httpCode = 400 or 401! =======');
        print(response.body);
        print('error');
      }



    } else {
      NaverLoginResult res = userData['data'] as NaverLoginResult;
      NaverAccountResult naverUser = res.account;

      memberRegist.userNm = naverUser.name;
      memberRegist.userEmail = naverUser.email;
      memberRegist.userPhone = naverUser.mobile;
      memberRegist.userBirth = '${naverUser.birthyear}${naverUser.birthday.replaceAll("-", "")}';
      memberRegist.userGender = naverUser.gender;
      print(memberRegist.userGender);
      memberRegist.pinCode = kioskTextFieldController.text;
      memberRegist.platform = "N";
      memberRegist.platformId = naverUser.id;
      memberRegist.parentPhone = parentPhoneTextFieldController.text;
      memberRegist.parentAlarm = parentalConsent ? "Y" : "N";

      Response response = await restApi.register(memberRegist);
      var httpCode = response.statusCode;

      print('======== pressRegisterBtn() Naver! =======');
      print('status code : $httpCode');

      if (httpCode == 201) {
        print('======== pressRegisterBtn() Naver!  httpCode = 201! =======');
        print('회원가입 성공 회성공 페이지로 이동');
        Navigator.pushNamed(context, RoutePath.registerSuccessPage);
      } else {
        print('======== pressRegisterBtn() Naver!  httpCode = 400 or 401! =======');

        print(response.body);
        print('error');
      }


    }




    // Dmon 카카오 계정 전번, 이름  없음



  }
}
