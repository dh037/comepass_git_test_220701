import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/color_code.dart';
import '../../notifier/register/register_consent_notifier.dart';

class RegisterConsentScreen extends StatefulWidget {
  const RegisterConsentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterConsentScreen> createState() => _RegisterConsentScreenState();
}

class _RegisterConsentScreenState extends State<RegisterConsentScreen> {
  late RegisterConsentNotifier _registerNotifier;

  @override
  void initState() {
    super.initState();
    _registerNotifier = context.read<RegisterConsentNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        createLeadingIcon: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w, bottom: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('컴패스 회원가입을 위한 \n이용약관에 동의해주세요',
                  style: TextStyle(
                      height: 1.4.sp,
                      color: ColorCode.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: _registerNotifier.onTabAllCheck,
                child: Row(
                  children: [
                    Consumer<RegisterConsentNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            _registerNotifier.allCheck
                                ? SvgPicture.asset(
                                    IconPath.iconCheckBoxSolidSelected,
                                    width: 20.w,
                                    height: 20.w,
                                  )
                                : SvgPicture.asset(
                                    IconPath.iconCheckBoxDefault,
                                    width: 20.w,
                                    height: 20.w,
                                  )),
                    SizedBox(width: 7.w),
                    Text(
                      '전체동의',
                      style: TextStyle(fontSize: 18.sp, color: ColorCode.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 19.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () {
                    _registerNotifier.serviceCheck =
                        !_registerNotifier.serviceCheck;
                    _registerNotifier.allCheckValidation();
                    _registerNotifier.notifyListener();
                  },
                  child: Row(
                    children: [
                      Consumer<RegisterConsentNotifier>(
                          builder: (BuildContext context, value,
                                  Widget? child) =>
                              SvgPicture.asset(IconPath.iconCheckmarkDerault,
                                  color: _registerNotifier.serviceCheck
                                      ? ColorCode.green50
                                      : ColorCode.grey60)),
                      SizedBox(width: 11.76.sp),
                      Text('서비스 이용약관', style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(122321);
                  },
                  child: Text('보기',
                      style:
                          TextStyle(color: ColorCode.grey60, fontSize: 12.sp)),
                )
              ]),
              SizedBox(height: 8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () {
                    _registerNotifier.infoCheck = !_registerNotifier.infoCheck;
                    _registerNotifier.allCheckValidation();
                    _registerNotifier.notifyListener();
                  },
                  child: Row(
                    children: [
                      Consumer<RegisterConsentNotifier>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  SvgPicture.asset(
                                    IconPath.iconCheckmarkDerault,
                                    color: _registerNotifier.infoCheck
                                        ? ColorCode.green50
                                        : ColorCode.grey60,
                                  )),
                      SizedBox(width: 11.76.sp),
                      Text('개인정보 수집 및 이용', style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(1);
                  },
                  child: Text('보기',
                      style:
                          TextStyle(color: ColorCode.grey60, fontSize: 12.sp)),
                )
              ]),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  _registerNotifier.adCheck = !_registerNotifier.adCheck;
                  _registerNotifier.allCheckValidation();
                  _registerNotifier.notifyListener();
                },
                child: Row(children: [
                  Consumer<RegisterConsentNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          SvgPicture.asset(IconPath.iconCheckmarkDerault,
                              color: _registerNotifier.adCheck
                                  ? ColorCode.green50
                                  : ColorCode.grey60)),
                  SizedBox(width: 11.76.sp),
                  Text('광고성 문자 수신 여부(선택)', style: TextStyle(fontSize: 14.sp)),
                ]),
              ),
            ]),
            Consumer<RegisterConsentNotifier>(
                builder: (BuildContext context2, value, Widget? child) =>
                    confirmBtn(context))
          ],
        ),
      ),
    );
  }

  Widget confirmBtn(BuildContext context) {
    if (_registerNotifier.serviceCheck && _registerNotifier.infoCheck) {
      return CustomButton.stretchTextBtnGreen50White(
          text: "확인",
          onPressed: () {
            _registerNotifier.pressConfirmBtn(context);
          });
    }
    return CustomButton.stretchTextBtnDisabledGreen(text: '확인');
  }
}

