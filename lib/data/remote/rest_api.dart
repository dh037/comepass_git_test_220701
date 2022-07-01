import 'dart:convert';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/encrypt.dart';
import 'package:comepass/data/local/get_device_info.dart';
import 'package:comepass/data/model/member_regist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class RestApi {

  var _uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224c';
  // var _uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224b';
  // var _uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224f'; // kakao
  // var _uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224g'; // naver

  /// 인증 ======================================================================
  authorize() async {
    Map<String, dynamic> data = await GetDeviceInfo().getDeviceInfo();


    var authorizeHeader = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Dmon-Device-UUID': _uuid //data['uuid'].toString()
    };

    var uri = Uri.parse('https://devapi.comepass.kr/auth/authorize');

    var response = await http.post(uri, headers: authorizeHeader);

    Map<String, dynamic> clientIdJsonData = jsonDecode(response.body);

    print('======= authorize() =======');
    print(' uuid  =  $_uuid');
    print(' client Id  =  ${clientIdJsonData['client_id']}');

    return clientIdJsonData['client_id'];
  }

  /// ==========================================================================

  /// 로그인 =====================================================================

  kakaoLogin(dynamic userData) async {
    Map<String, dynamic> data = await GetDeviceInfo().getDeviceInfo();


    String clientId = await authorize();

    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
      "X-Dmon-Device-Os": data['os'],
      "X-Dmon-Device-OsVer": data['osVer'],
      "X-Dmon-Device-Model": data['model']
    };

    var uri = Uri.parse('https://devapi.comepass.kr/login/app');
    var req = Encrypt().encrypt('{"client_id" : "$clientId", "platform" : {"login_type" : "K", "acct" : $userData } }');


    print('======== kakaoLogin() =======');
    print('uuid 확인 : $_uuid');
    print('header 확인 $postHeader');
    print('data 확인 ${Encrypt().decrypt(req)}');

    var response =
        await http.post(uri, body: {"req": req}, headers: postHeader);

    return response;
  }

  naverLogin(NaverLoginResult userData) async {
    Map<String, dynamic> data = await GetDeviceInfo().getDeviceInfo();


    String clientId = await authorize();


    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
      "X-Dmon-Device-Os": data['os'],
      "X-Dmon-Device-OsVer": data['osVer'],
      "X-Dmon-Device-Model": data['model']
    };

    var uri = Uri.parse('https://devapi.comepass.kr/login/app');

    var req = Encrypt().encrypt('{"client_id" : "$clientId", "platform" : {"login_type" : "N", "acct" : ${jsonEncode(userData.account)} } }');


    print('======== naverLogin() =======');
    print('uuid 확인 : $_uuid');
    print('header 확인 $postHeader');
    print('data 확인 ${Encrypt().decrypt(req)}');

    var response =
        await http.post(uri, body: {"req": req}, headers: postHeader);

    return response;
  }

  comepassLogin(
      {required String? id,
      required String? pwd}) async {
    Map<String, dynamic> data = await GetDeviceInfo().getDeviceInfo();
    String clientId = await authorize();
    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
      "X-Dmon-Device-Os": data['os'],
      "X-Dmon-Device-OsVer": data['osVer'],
      "X-Dmon-Device-Model": data['model']
    };
    var uri = Uri.parse('https://devapi.comepass.kr/login/app');
    var req = Encrypt().encrypt(
        '{"client_id": "$clientId" ,"platform" : {"login_type" : "C", "acct" : {"id" : "$id", "pwd" : "$pwd"}}}');
    var response =
        await http.post(uri, body: {"req": req}, headers: postHeader);
    return response;
  }

  /// 인증요청 ==========================================================================


  certificationReq({required String isSend, required String phone}) async {
    String phoneData = '010${phone.replaceAll(' ', '')}';

    var uri = Uri.parse('https://devapi.comepass.kr/auth/code');

    var req = {"req_type": isSend, "device": "app", "user_phone": phoneData};

    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
    };


    var response = await http.post(uri, body: req, headers: postHeader);

    return response;
  }

  findId(
      {required String name,
      required String phone,
      required String birth}) async {
    var uri = Uri.parse('https://devapi.comepass.kr/user/findid');
    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
    };
    var req = {"user_nm": name, "user_phone": "010$phone", "user_birth": birth};
    print(req);
    var response = await http.post(uri, body: req, headers: postHeader);

    return response;
  }

  findPwd(
      {required String reqType,
      required String id,
      required String name,
      required String phone,
      required String authCode,
      String? birth,
      String? kioskCode}) async {

    var uri = Uri.parse('https://devapi.comepass.kr/user/userverify');
    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
    };
    var req;

    req = Encrypt().encrypt(
        '{"req_type" : "$reqType", "user_id" : "$id", "user_nm" : "$name", "user_phone" : "010${phone.replaceAll(" ", "")}", "auth_code" : "$authCode"}');

    if (birth != null && kioskCode != null) {
      req = Encrypt().encrypt(
          '{"req_type" : "$reqType", "user_id" : "$id", "user_nm" : "$name", "user_phone" : "010${phone.replaceAll(" ", "")}","user_birth": "${birth.replaceAll(" ", "")}", "auth_code" : "$authCode", "pin_code": "$kioskCode"}');
    }


    print(Encrypt().decrypt(req));

    var response =
        await http.post(uri, body: {"req": req}, headers: postHeader);

    return response;
  }

  changePwd(
      {required String index,
      required String pwd,
      required String pwdConfirm}) async {
    Uri uri = Uri.parse("https://devapi.comepass.kr/user/changepwd");

    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
    };

    var req = Encrypt().encrypt(
        '{"m_idx" : "$index", "user_pw" : "$pwd", "user_pw_confirm" : "$pwdConfirm"}');
    print(Encrypt().decrypt(req));
    var response =
        await http.post(uri, body: {"req": req}, headers: postHeader);
    return response;
  }

  register(MemberRegist memberRegist) async{

    Uri uri = Uri.parse("https://devapi.comepass.kr/login/regist");
    Map<String, dynamic> data = await GetDeviceInfo().getDeviceInfo();

    // var _uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224d';


    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": _uuid,
      "X-Dmon-Device-Os": data['os'],
      "X-Dmon-Device-OsVer": data['osVer'],
      "X-Dmon-Device-Model": data['model']
    };



    var req = Encrypt().encrypt(jsonEncode(memberRegist));

    print('---------- register()  ----------');

    print('uuid 재차 확인 : $_uuid');
    print('header 확인 : $postHeader');
    print('data 확인 : {"req" : ${Encrypt().decrypt(req)}}');



    Response response = await http.post(uri, body: {"req": req}, headers: postHeader);
    return response;
  }
}
