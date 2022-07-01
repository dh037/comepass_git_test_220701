import 'dart:async';
import 'dart:convert';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/remote/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants/icon_path.dart';
import '../../data/model/member_regist.dart';

class RegisterCertificationNotifier extends ChangeNotifier {
  late MemberRegist memberRegist;

  bool pressCertificationBtn = false;
  String certificationBtnText = "인증요청";

  String? errorString;

  Timer? timer;
  String timerString = "";
  RestApi restApi = RestApi();


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

  certificationCodeValidator(String? value) {
    certificationCodeState = true;
    if (value!.length < 6) {
      certificationCodeState = false;
    }
    notifyListeners();
  }


  // 인증코드 일치하는지 확인하기 위한 변수
  late String code;


  certificationBtn () async {

    Response response;

    if (!pressCertificationBtn) {
      response = await restApi.certificationReq(isSend: "SEND", phone: phoneTextFieldController.text);
    } else {
      response = await restApi.certificationReq(isSend: "RESEND", phone: phoneTextFieldController.text);
    }

    var httpCode = response.statusCode;
    var httpBody = jsonDecode(response.body);

    print(httpCode);
    print(httpBody);

    code = httpBody['msg'];

    pressCertificationBtn = true;
    certificationBtnText = '재인증';

    startTimer();
    notifyListeners();
  }


  startTimer() {
    timer?.cancel();

    timerString = DateTime(0, 0, 0, 0, 3).toString().substring(15, 20);
    notifyListeners();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      // 1000/ 100 분의 속도로 돌리고!
      timerString = DateTime(0, 0, 0, 0, 3) // 3분 제한
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



  pressConfirmBtn(BuildContext context) {

    if (certificationCodeTextFieldController.text != code) {

      errorString = "인증번호가 잘못되었습니다.";

      notifyListeners();
    } else if (timer?.tick == 180){
      errorString = "시간이 초과되었습니다.";
      notifyListeners();
    } else {
      errorString = null;
      notifyListeners();

      var userPhone = '010${phoneTextFieldController.text.replaceAll(" ", "")}';

      memberRegist.userPhone = userPhone;
      memberRegist.authCode = certificationCodeTextFieldController.text;

      Navigator.pushNamed(context, RoutePath.registerIdPwdPage, arguments: memberRegist);
    }
  }
}