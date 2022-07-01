import 'dart:convert';

import 'package:comepass/components/custom_button.dart';
import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/notifier/register/register_kiosk_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/cupertino_progressbar.dart';
import '../../components/custom_appbar.dart';
import '../../data/model/member_regist.dart';

class RegisterKioskScreen extends StatefulWidget {
  const RegisterKioskScreen({Key? key}) : super(key: key);

  @override
  State<RegisterKioskScreen> createState() => _RegisterKioskScreenState();
}

class _RegisterKioskScreenState extends State<RegisterKioskScreen> {
  late RegisterKioskNotifier _registerKioskNotifier;

  @override
  void initState() {
    super.initState();
    _registerKioskNotifier = context.read<RegisterKioskNotifier>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;
    _registerKioskNotifier.memberRegist = args as MemberRegist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(createLeadingIcon: true),
      body: content(context),
    );
  }

  content(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomCupertinoProgressbar(value: 1),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.h),
                    Text('키오스크 출입코드를\n이용해주세요',
                        style: TextStyle(
                          height: 1.4.sp,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height: 8.h),
                    Text("출입시 키오스크 로그인에 사용되는 번호입니다.",
                        style: TextStyle(
                            color: const Color(0xffAEB0B5),
                            fontSize: 14.sp,
                            height: 1.4.sp)),
                    SizedBox(height: 50.h),
                    CustomTextField(
                      styleHandling: true,
                      obscureText: true,
                      maxLength: 4,
                      hintText: '키오스크 출입코드',
                      controller:
                          _registerKioskNotifier.kioskTextFieldController,
                      onChanged: _registerKioskNotifier.kioskValidator,
                    ),
                    SizedBox(height: 4.h),
                    Row(children: [
                      Consumer<RegisterKioskNotifier>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  SizedBox(
                                    width: 17.w,
                                    height: 17.w,
                                    child: SvgPicture.asset(
                                        IconPath.iconCheckmarkDerault,
                                        color: _registerKioskNotifier.kioskState
                                            ? ColorCode.green50
                                            : ColorCode.grey50),
                                  )),
                      Consumer<RegisterKioskNotifier>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  Text('숫자4자리',
                                      style: TextStyle(
                                        color: _registerKioskNotifier.kioskState
                                            ? ColorCode.green50
                                            : ColorCode.grey50,
                                        fontSize: 12.sp,
                                      )))
                    ]),
                    SizedBox(height: 18.h),
                    CustomTextField(
                      styleHandling: true,
                      obscureText: true,
                      maxLength: 4,
                      hintText: '키오스크 출입코드 확인',
                      controller: _registerKioskNotifier
                          .kioskConfirmTextFieldController,
                      onChanged: _registerKioskNotifier.kioskConfirmValidator,
                    ),
                    SizedBox(height: 4.h),
                    Row(children: [
                      Consumer<RegisterKioskNotifier>(
                          builder: (BuildContext context, value,
                                  Widget? child) =>
                              SizedBox(
                                width: 17.w,
                                height: 17.w,
                                child: SvgPicture.asset(
                                    IconPath.iconCheckmarkDerault,
                                    color:
                                        _registerKioskNotifier.kioskConfirmState
                                            ? ColorCode.green50
                                            : ColorCode.grey50),
                              )),
                      Consumer<RegisterKioskNotifier>(
                          builder: (BuildContext context, value,
                                  Widget? child) =>
                              Text('키오스크 출입코드와 동일',
                                  style: TextStyle(
                                    color:
                                        _registerKioskNotifier.kioskConfirmState
                                            ? ColorCode.green50
                                            : ColorCode.grey50,
                                    fontSize: 12.sp,
                                  )))
                    ]),
                  ],
                ),
              )
            ],
          ),
          Consumer<RegisterKioskNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  registerBtn())
        ],
      ),
    );
  }

  Widget registerBtn() {
    return _registerKioskNotifier.kioskState &&
            _registerKioskNotifier.kioskConfirmState
        ? Padding(
            padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
            child: CustomButton.stretchTextBtnGreen50White(
                text: "회원가입",
                onPressed: () =>
                    _registerKioskNotifier.pressRegisterBtn(context)))
        : Padding(
            padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
            child: CustomButton.stretchTextBtnDisabledGreen(text: "회원가입"));
  }
}
