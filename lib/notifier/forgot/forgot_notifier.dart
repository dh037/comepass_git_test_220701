import 'dart:async';
import 'dart:convert';
import 'package:comepass/components/custom_dialog.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/regex.dart';
import 'package:comepass/data/remote/dio_test.dart';
import 'package:comepass/data/remote/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants/color_code.dart';

enum ScreenState { id, pwd }

class ForgotNotifier extends ChangeNotifier {
  var restApi = RestApi();
  var dio = DioTest();
  late String code;

  late ScreenState screenState;
  late String findPwdMemberIndex;
  bool resetPwd = true;

  Timer? timer;

  void onPressedFindIdBtn() {
    screenState = ScreenState.id;
    notifyListeners();
  }

  void onPressedFindPwdBtn() {
    screenState = ScreenState.pwd;
    notifyListeners();
  }

  // find id Notifier

  bool findIdNameCheck = false;
  bool findIdBirthCheck = false;
  bool findIdPhoneCheck = false;

  var findIdNameTextFieldController = TextEditingController();
  var findIdBirthTextFieldController = TextEditingController();
  var findIdPhoneTextFieldController = TextEditingController();

  findIdNameValidator(isChecked) {
    findIdNameCheck = isChecked;
    notifyListeners();
  }

  findIdBirthValidator(isChecked) {
    findIdBirthCheck = isChecked;
    notifyListeners();
  }

  findIdPhoneValidator(isChecked) {
    findIdPhoneCheck = isChecked;
    notifyListeners();
  }

  pressFindIdBtn(BuildContext context) async {
    var birth = findIdBirthTextFieldController.text.replaceAll(' ', '');
    var name = findIdNameTextFieldController.text.replaceAll(" ", "");
    var phone = findIdPhoneTextFieldController.text.replaceAll(" ", "");

    var response = await restApi.findId(name: name, phone: phone, birth: birth);

    var httpCode = response.statusCode;
    var httpBody = jsonDecode(response.body);

    var data = {"name": name, "id": httpBody['msg']};

    print(httpBody);

    // 200 : 정상완료, 201 : 정상 insert, 400 : 비정상 처리, 401 : 인증실패

    if (httpCode >= 400) {
      // error
      CustomDialog().flutterDialog(
          context: context,
          title: '계정찾기 불가',
          content: "가입정보를 찾을 수 없습니다.\n회원가입을 진행하시겠습니까?");
      return;
    }
    Navigator.pushNamed(context, RoutePath.findIdSuccess, arguments: data);
  }

  // Find pwd Notifier

  bool isOnPressedCertificationBtn = false;
  String certificationBtnText = '인증요청';
  String timerString = "";
  String? errorText;

  bool findPwdIdCheck = false;
  bool findPwdNameCheck = false;
  bool findPwdPhoneCheck = false;
  bool findPwdCertificationCodeCheck = false;

  var findPwdIdTextFieldController = TextEditingController();
  var findPwdNameTextFieldController = TextEditingController();
  var findPwdPhoneTextFieldController = TextEditingController();
  var findPwdCertificationCodeTextFieldController = TextEditingController();

  findPwdIdValidator(isChecked) {
    findPwdIdCheck = isChecked;
    notifyListeners();
  }

  findPwdNameValidator(isChecked) {
    findPwdNameCheck = isChecked;
    notifyListeners();
  }

  findPwdPhoneValidator(String? value) {
    findPwdPhoneCheck = true;
    if (value!.length < 9) {
      findPwdPhoneCheck = false;
    }
    notifyListeners();
  }

  findPwdCertificationCodeValidator(String? value) {
    findPwdCertificationCodeCheck = true;
    if (value!.length < 6) {
      findPwdCertificationCodeCheck = false;
    }
    notifyListeners();
  }

  void certificationBtn(BuildContext context) async {
    // 처음이라면?
    Response response;

    if (isOnPressedCertificationBtn) {
      response = await restApi.certificationReq(
          phone: findPwdPhoneTextFieldController.text, isSend: "RESEND");
    } else {
      response = await restApi.certificationReq(
          phone: findPwdPhoneTextFieldController.text, isSend: "SEND");
    }

    // code = await dio.certificationReq2(isSend: "SEND", phone:findPwdPhoneInputTextFieldController.text);

    print(response.body);

    var httpCode = response.statusCode;

    code = jsonDecode(response.body)['msg'];

    if (httpCode >= 400) {
      // error
      CustomDialog()
          .failCertification(context: context, title: '인증번호 발송에 실패했습니다');
      return;
    }

    isOnPressedCertificationBtn = true;
    certificationBtnText = "재인증";
    notifyListeners();
    startTimer();
  }

  startTimer() {
    timer?.cancel();

    timerString = DateTime(0, 0, 0, 0, 3).toString().substring(15, 20);
    notifyListeners();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerString = DateTime(0, 0, 0, 0, 3)
          .difference(DateTime(0, 0, 0, 0, 0, timer.tick))
          .toString()
          .substring(2, 7);
      notifyListeners();
      if (timer.tick.toInt() == 180) {
        timer.cancel();
      }
    });
  }

  Color certificationCodeTextFieldBorderColor = ColorCode.greyBorder;
  Color certificationCodeTextFieldFocusedBorderColorCursorColor =
      ColorCode.green50;

  pressFindPwdBtn(BuildContext context) async {
    var id = findPwdIdTextFieldController.text;
    var name = findPwdNameTextFieldController.text;
    var phone = findPwdPhoneTextFieldController.text;
    var authCode = findPwdCertificationCodeTextFieldController.text;

    if (timer?.tick.toInt() == 180) {
      certificationCodeTextFieldBorderColor = ColorCode.red50;
      certificationCodeTextFieldFocusedBorderColorCursorColor = ColorCode.red50;
      errorText = "시간이 초과되었습니다. 재인증을 해주세요";
      notifyListeners();
    } else if (findPwdCertificationCodeTextFieldController.text !=
        code.toString()) {
      certificationCodeTextFieldBorderColor = ColorCode.red50;
      certificationCodeTextFieldFocusedBorderColorCursorColor = ColorCode.red50;
      errorText = "인증번호가 일치하지 않습니다";
      notifyListeners();
    } else {
      certificationCodeTextFieldBorderColor = ColorCode.greyBorder;
      certificationCodeTextFieldFocusedBorderColorCursorColor =
          ColorCode.green50;
      errorText = "";
      notifyListeners();
      Response response = await restApi.findPwd(
          reqType: "info",
          id: id,
          name: name,
          phone: phone.replaceAll(" ", ""),
          authCode: authCode);
      // var response = await dio.findPwd2(reqType: "info", id: id, name: name, phone: '010${phone.replaceAll(" ", "")}', authCode: authCode);

      var httpCode = response.statusCode;
      var httpBody = jsonDecode(response.body);

      if (httpCode >= 400) {
        if (httpBody['code'] == "2511") {
          print('가입된 정보랑 다르니 그 페이로 이동 ㄱ');
          Navigator.pushNamed(context, RoutePath.findPwdAddInfo);
        }
        if (httpBody['code'] == "1001") {
          CustomDialog()
              .failCertification(context: context, title: "알 수 없는 에러!");
        }
        return;
      }

      findPwdMemberIndex = httpBody['msg'];
      screenState = ScreenState.pwd;
      resetPwd = true;
      notifyListeners();
    }
  }

  // Reset Password
  var resetPwdTextFieldController = TextEditingController();
  var resetPwdConfirmTextFieldController = TextEditingController();

  bool resetPwdTextFieldInputString = false;
  bool resetPwdTextField8orMore = false;
  bool resetPwdTextField20ofLess = false;
  bool resetPwdTextFieldConfirm = false;

  void resetPwdValidator(String? value) {
    resetPwdTextFieldInputString = false;
    resetPwdTextField8orMore = false;
    resetPwdTextField20ofLess = false;

    if (Regex.passwordRule().hasMatch(value!)) {
      resetPwdTextFieldInputString = true;
      notifyListeners();
    }

    if (value.length >= 8) {
      resetPwdTextField8orMore = true;
      notifyListeners();
    }

    if (value.length <= 20 && value.isNotEmpty) {
      resetPwdTextField20ofLess = true;
      notifyListeners();
    }

    if (value == resetPwdConfirmTextFieldController.text &&
        resetPwdConfirmTextFieldController.text.isNotEmpty) {
      resetPwdTextFieldConfirm = true;
      notifyListeners();
    } else {
      resetPwdTextFieldConfirm = false;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetPwdConfirmValidator(String? value) {
    resetPwdTextFieldConfirm = false;

    if (value! == resetPwdTextFieldController.text) {
      resetPwdTextFieldConfirm = true;
      notifyListeners();
    }

    notifyListeners();
  }

  pressResetPwdBtn(BuildContext context) async {
    print(findPwdMemberIndex);
    Response response = await RestApi().changePwd(
        index: findPwdMemberIndex,
        pwd: resetPwdTextFieldController.text,
        pwdConfirm: resetPwdConfirmTextFieldController.text);

    var httpBody = jsonDecode(response.body);
    var httpCode = response.statusCode;

    print(httpBody);
    print(httpCode);

    if (httpCode >= 400) {
      if (httpBody['code'] == "1001") {
        CustomDialog().failCertification(context: context, title: "알 수 없는 에러입니다.");
      }
      return;
    }

    Navigator.pushNamed(context, RoutePath.findPwdSuccess);
  }
}
