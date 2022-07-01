
import 'dart:convert';

import 'package:dio/dio.dart';

import '../encrypt.dart';


class DioTest {
  var uuid = '01ea6d46-1b8e-427d-8dfa-a20ea577224c';
  var dio = Dio();

  certificationReq2({required String isSend, required String phone}) async {
    print(1);
    String phoneData = '010${phone.replaceAll(' ', '')}';

    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": uuid,
    };

    var req = {"req_type": isSend, "user_phone": phoneData};

    var response = await dio.post(
        "https://devapi.comepass.kr/auth/code",
        data: req,
        options: Options(headers: postHeader)
    );


    print(response.data['msg']);

    return response.data['msg'];

  }


  findPwd2(
      {required String reqType,
        required String id,
        required String name,
        required String phone,
        required String authCode}) async {

    print(1);

    Map<String, String>? postHeader = {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Dmon-Device-UUID": uuid,
    };
    print(Encrypt().encrypt('{"req_type" : "$reqType", "user_id" : "$id", "user_nm" : "$name", "user_phone" : "$phone", "auth_code" : "$authCode"}'));
    String req = Encrypt().encrypt('{"req_type" : "$reqType", "user_id" : "$id", "user_nm" : "$name", "user_phone" : "$phone", "auth_code" : "$authCode"}');


    var response = await dio.post("https://devapi.comepass.kr/user/userverify", data: {'req' : req },options: Options(headers: postHeader));
    print(response.data);

  }

}
