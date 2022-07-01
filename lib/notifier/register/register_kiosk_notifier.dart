import 'dart:convert';
import 'package:comepass/data/model/member_regist.dart';
import 'package:comepass/data/remote/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants/routes_path.dart';

class RegisterKioskNotifier extends ChangeNotifier {
  late MemberRegist memberRegist;
  RestApi restApi = RestApi();

  var kioskTextFieldController = TextEditingController();
  bool kioskState = false;

  kioskValidator(String? value) {
    kioskState = true;

    if (value!.length < 4) {
      kioskState = false;
    }

    if (value != kioskConfirmTextFieldController.text &&
        kioskConfirmTextFieldController.text.isEmpty) {
      kioskConfirmState = false;
      notifyListeners();
    } else {
      kioskConfirmState = true;
      notifyListeners();
    }

    notifyListeners();
  }

  var kioskConfirmTextFieldController = TextEditingController();
  bool kioskConfirmState = false;

  kioskConfirmValidator(String? value) {
    kioskConfirmState = true;

    if (value != kioskTextFieldController.text) {
      kioskConfirmState = false;
    }

    notifyListeners();
  }

  pressRegisterBtn(BuildContext context) async {
    memberRegist.pinCode = kioskConfirmTextFieldController.text;
    memberRegist.platform = "C";

    // 임시
    memberRegist.parentPhone = "01012342222";
    //


    Response response = await restApi.register(memberRegist);
    var httpCode = response.statusCode;

    print(httpCode);

    if (httpCode >= 400) {
      print('---------- pressRegisterBtn() httpCode = 400 or 401!  ----------');
      var httpBody = jsonDecode(response.body);
      print(httpBody);
      return;
    }

    print('---------- pressRegisterBtn() httpCode = 200!  ----------');
    print('회원가입 성공 페이지로 이동');
    Navigator.pushNamed(context, RoutePath.registerSuccessPage);
  }
}
