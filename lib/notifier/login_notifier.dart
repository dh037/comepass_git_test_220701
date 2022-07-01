import 'dart:convert';

import 'package:comepass/components/custom_dialog.dart';
import 'package:comepass/data/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import '../constants/color_code.dart';
import '../constants/routes_path.dart';
import '../data/remote/rest_api.dart';
import 'forgot/forgot_notifier.dart';

class LoginNotifier extends ChangeNotifier {
  RestApi restApi = RestApi();

  bool isLoading = false;

  final idTextFieldController = TextEditingController(text: "test02");
  final pwdTextFieldController = TextEditingController(text: "test002@");

  FocusNode idFocusNode = FocusNode();
  FocusNode pwdFocusNode = FocusNode();

  Color idTextFieldBorderColor = ColorCode.greyBorder;
  Color idTextFieldFocusBorderColorCursorColor = ColorCode.green50;

  Color pwdTextFieldBorderColor = ColorCode.greyBorder;
  Color pwdTextFieldFocusBorderColorCursorColor = ColorCode.green50;

  String? errorMessage;

  void comepassLoginBtn(BuildContext context) async {

    if (idTextFieldController.text.isEmpty) {
      idErrorStyle();
      pwdNormalStyle();
      errorMessage = '아이디를 입력하세요';
      notifyListeners();
    } else if (idTextFieldController.text.contains(" ")) {
      idErrorStyle();
      pwdNormalStyle();
      errorMessage = '아이디에 공백은 포함할 수 없습니다.';
      idTextFieldController.text = "";
      notifyListeners();
    } else if (!Regex.idRule().hasMatch(idTextFieldController.text)) {
      idErrorStyle();
      pwdNormalStyle();
      errorMessage = '아이디는 영문+숫자조합 5자 이상 12자 이하입니다.';
      idTextFieldController.text = "";
      notifyListeners();
    } else if (pwdTextFieldController.text.isEmpty) {
      idNormalStyle();
      pwdErrorStyle();
      errorMessage = '비밀번호를 입력하세요';
      notifyListeners();
    } else if (pwdTextFieldController.text.contains(" ")) {
      idNormalStyle();
      pwdErrorStyle();
      errorMessage = '비밀번호는 공백은 포함할 수 없습니다.';
      pwdTextFieldController.text = "";
      notifyListeners();
     } else if (!Regex.passwordRule().hasMatch(pwdTextFieldController.text)) {
      idNormalStyle();
      pwdErrorStyle();
      errorMessage = '비밀번호는 영문+숫자+특수문자 조합 8자 이상 20자 이하입니다.';
      pwdTextFieldController.text = "";
      notifyListeners();
    } else {
      idNormalStyle();
      pwdNormalStyle();
      errorMessage = null;
      notifyListeners();

      isLoading = true;
      notifyListeners();

      Response response = await restApi.comepassLogin(
          id: idTextFieldController.text, pwd: pwdTextFieldController.text);

      isLoading = false;
      notifyListeners();

      var httpCode = response.statusCode;
      var httpBody = jsonDecode(response.body);
      print(httpCode);
      print(httpBody);


      if (httpCode >= 400) {
        idNormalStyle();
        pwdErrorStyle();

        if (httpBody['code'] == "2019") {
          errorMessage = httpBody['msg'];
          notifyListeners();
        } else {
          errorMessage = "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해주세요";
          notifyListeners();
        }
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
          context, RoutePath.mainPage, (route) => false);
    }
  }



  void kakaoLoginBtn(BuildContext context) async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      try {
        User user = await UserApi.instance.me();
        // 생년월일, 전화번호로 db에 저장된 회원인지 확인함
        // user 정보 확인해주고~
        print(jsonEncode(user));
        Response response = await restApi.kakaoLogin(jsonEncode(user));

        var httpCode = response.statusCode;
        var httpBody = jsonDecode(response.body);
        print(httpBody);
        if (httpCode >= 400) {
          print('---------- kakaoLoginBtn() http_code = 400, 401 ----------');
          CustomDialog().failCertification(context: context, title: "알 수 없는 에러!");
          return;
        }

        if (httpBody['success'] == false) {
          print('---------- kakaoLoginBtn() http_code = 200----------');
          print ('success = false 가입 안되있음 sso 회원가입 페이지로 이동');
          var args = {
            "platform" : "kakao",
            "data" : user
          };
          Navigator.pushNamed(context, RoutePath.ssoRegisterPage,arguments: args);
        }

      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }

  void naverLoginBtn(BuildContext context) async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    Response response = await restApi.naverLogin(res);
    var httpBody = jsonDecode(response.body);
    var httpCode = response.statusCode;


    if (httpCode >= 400) {
      print('---------- NaverLoginBtn() http_code = 400, 401 ----------');
      print(jsonEncode(response.body));
      return;
    }
    print('---------- NaverLoginBtn() httpCode = 200!----------');

    if (httpBody['success'] == false) {
      print ('success = false');
      print(' sso 회원가입 페이지로 이동');

      var args = {
        "platform" : "naver",
        "data" : res
      };

      Navigator.pushNamed(context, RoutePath.ssoRegisterPage,arguments: args);
    }
  }

  void registerBtn(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.registerConsentPage);
  }

  void findIdBtn(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.forgotPage,
        arguments: {"screenState": ScreenState.id, "resetPwd": false});
  }

  void findPwdBtn(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.forgotPage,
        arguments: {"screenState": ScreenState.pwd, "resetPwd": false});
  }

  void idErrorStyle() {
    idTextFieldFocusBorderColorCursorColor = ColorCode.red50;
    idTextFieldBorderColor = ColorCode.red50;
    idFocusNode.requestFocus();
  }

  void pwdErrorStyle() {
    pwdTextFieldFocusBorderColorCursorColor = ColorCode.red50;
    pwdTextFieldBorderColor = ColorCode.red50;
    pwdFocusNode.requestFocus();
  }

  void idNormalStyle() {
    idTextFieldFocusBorderColorCursorColor = ColorCode.green50;
    idTextFieldBorderColor = ColorCode.greyBorder;
  }

  void pwdNormalStyle() {
    pwdTextFieldFocusBorderColorCursorColor = ColorCode.green50;
    pwdTextFieldBorderColor = ColorCode.greyBorder;
  }
}
