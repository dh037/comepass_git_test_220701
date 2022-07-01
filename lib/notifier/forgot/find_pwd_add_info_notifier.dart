import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/remote/rest_api.dart';
import 'package:comepass/notifier/forgot/forgot_notifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class FindPwdAddInfoNotifier extends ChangeNotifier {

  var restApi = RestApi();

  Timer? timer;
  String timerString = "";

  String certificationBtnText = "인증요청";
  bool pressCertificationBtn = false;


  appBarBackBtn(BuildContext context) {

    Navigator.pop(context);
  }

  var idTextFieldController = TextEditingController();
  bool idState = false;
  idValidator(state) {
    idState = state;
    notifyListeners();
  }

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

  var kioskCodeTextFieldController = TextEditingController();
  bool kioskCodeState = false;
  kioskCodeValidator(state) {
    kioskCodeState = state;
    notifyListeners();
  }


  var phoneTextFieldController = TextEditingController();
  bool phoneState = false;
  phoneValidator(String? value) {
    phoneState = true;
    if (value!.length < 9) {
      phoneState = false;
    }
    notifyListeners();
  }



  var certificationCodeTextFieldController = TextEditingController();
  bool certificationCodeState = false;
  String certificationErrorMsg = "";
  Color certificationCodeBorderColor = ColorCode.greyBorder;
  Color certificationCodeFocusedBorderColorCursorColor = ColorCode.green50;
  certificationValidator(String? value){
    certificationCodeState = true;
    if (value!.length < 9) {
      certificationCodeState = false;
    }
    notifyListeners();
  }


  certificationBtn(BuildContext context) async {
    Response response;

    if (!pressCertificationBtn) {
      response = await restApi.certificationReq(
          phone: phoneTextFieldController.text, isSend: "RESEND");
    } else {
      response = await restApi.certificationReq(
          phone: phoneTextFieldController.text, isSend: "SEND");
    }

    print(response.body);

    pressCertificationBtn = true;
    certificationBtnText = "재인증";
    notifyListeners();
    startTimer();

  }

  findPwdBtn (BuildContext context) async {

    var id = idTextFieldController.text;
    var name = nameTextFieldController.text;
    var phone = phoneTextFieldController.text;
    var authCode = certificationCodeTextFieldController.text;

    var birth = birthTextFieldController.text;
    var kioskCode = kioskCodeTextFieldController.text;


    Response response = await restApi.findPwd(reqType: "info", id: id, name: name, phone: phone, authCode: authCode, birth: birth, kioskCode: kioskCode);

    var httpCode = response.statusCode;
    var httpBody = jsonDecode(response.body);



    print(httpBody);
    print(httpCode);

    if (httpCode == 200) {
      Navigator.pushNamed(context, RoutePath.forgotPage, arguments: {"screenState" : ScreenState.pwd, "resetPwd" : true, "memberIndex" : httpBody['msg']});

    }


  }

  startTimer() {
    timer?.cancel();

    timerString = DateTime(0, 0, 0, 0, 3).toString().substring(15, 20);
    notifyListeners();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 1000/ 100 분의 속도로 돌리고!
      timerString = DateTime(0, 0, 0, 0, 3) // 3분 제한
      // timerString = DateTime(0,0,0,0,0,5)
          .difference(DateTime(0, 0, 0, 0, 0, timer.tick))
          .toString()
          .substring(2, 7);
      notifyListeners();

      if (timer.tick.toInt() == 180) {
        notifyListeners();
        timer.cancel();
      }
    });
  }


}
