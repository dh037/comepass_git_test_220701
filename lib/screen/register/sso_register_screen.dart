import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/notifier/register/sso_register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../../constants/color_code.dart';
import '../../constants/icon_path.dart';
import '../../data/model/member_regist.dart';

class SsoRegisterScreen extends StatefulWidget {
  const SsoRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SsoRegisterScreen> createState() => _SsoRegisterScreenState();
}

class _SsoRegisterScreenState extends State<SsoRegisterScreen> {
  late SsoRegisterNotifier _ssoRegisterNotifier;

  @override
  void initState() {
    super.initState();
    _ssoRegisterNotifier = context.read<SsoRegisterNotifier>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;
    _ssoRegisterNotifier.userData = args as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar.customAppBar(onPressed: () {}, createLeadingIcon: true),
      body: content(),
    );
  }

  Widget content() {
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.only(top: 9.h, left: 24.w, right: 24.w, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 9.h),
                Text('회원가입에 필요한 \n필수정보를 추가해주세요',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        height: 1.4.sp)),
                SizedBox(height: 50.h),
                CustomTextField(
                  styleHandling: true,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  maxLength: 4,
                  hintText: '키오스크 출입코드',
                  controller: _ssoRegisterNotifier.kioskTextFieldController,
                  onChanged: _ssoRegisterNotifier.kioskValidator,
                ),
                SizedBox(height: 4.h),
                Row(children: [
                  Consumer<SsoRegisterNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: SvgPicture.asset(
                                IconPath.iconCheckmarkDerault,
                                color: _ssoRegisterNotifier.kioskState
                                    ? ColorCode.green50
                                    : ColorCode.grey50),
                          )),
                  Consumer<SsoRegisterNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Text('숫자4자리',
                              style: TextStyle(
                                color: _ssoRegisterNotifier.kioskState
                                    ? ColorCode.green50
                                    : ColorCode.grey50,
                                fontSize: 12.sp,
                              )))
                ]),
                SizedBox(height: 58.h),
                Text('보호자 메시지 전송',
                    style: TextStyle(
                        color: ColorCode.grey70,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    GestureDetector(
                        onTap: _ssoRegisterNotifier.onTapParentalConsent,
                        child: Consumer<SsoRegisterNotifier>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  SizedBox(
                            child: _ssoRegisterNotifier.parentalConsent
                                ? SvgPicture.asset(
                                    IconPath.iconCheckBoxSolidSelected)
                                : SvgPicture.asset(
                                    IconPath.iconCheckBoxDefault),
                            width: 18.w,
                            height: 18.w,
                          ),
                        )),
                    SizedBox(width: 7.w),
                    Text('이용 시 보호자에게 메시지 전송하기 (선택)',
                        style: TextStyle(fontSize: 14.sp))
                  ],
                ),
                SizedBox(height: 18.h),
                Consumer<SsoRegisterNotifier>(
                    builder: (BuildContext context, value, Widget? child) =>
                        CustomTextField(
                          styleHandling: true,
                          hintText: "보호자 연락처",
                          enabled: _ssoRegisterNotifier.parentalConsent,
                        )),
                SizedBox(height: 60.h),
                Text('가입을 위한 약관 동의',
                    style: TextStyle(
                        color: ColorCode.grey70,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: _ssoRegisterNotifier.onTapServiceCheckBox,
                            child: Consumer<SsoRegisterNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  SizedBox(
                                child: _ssoRegisterNotifier.serviceCheck
                                    ? SvgPicture.asset(
                                        IconPath.iconCheckBoxSolidSelected)
                                    : SvgPicture.asset(
                                        IconPath.iconCheckBoxDefault),
                                width: 18.w,
                                height: 18.w,
                              ),
                            )),
                        SizedBox(width: 7.w),
                        Text('서비스 이용약관(필수)', style: TextStyle(fontSize: 14.sp))
                      ],
                    ),
                    Text('보기',
                        style:
                            TextStyle(color: ColorCode.grey60, fontSize: 12.sp))
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: _ssoRegisterNotifier.onTapInfoCheckBox,
                            child: Consumer<SsoRegisterNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  SizedBox(
                                child: _ssoRegisterNotifier.infoCheck
                                    ? SvgPicture.asset(
                                        IconPath.iconCheckBoxSolidSelected)
                                    : SvgPicture.asset(
                                        IconPath.iconCheckBoxDefault),
                                width: 18.w,
                                height: 18.w,
                              ),
                            )),
                        SizedBox(width: 7.w),
                        Text('개인정보 수집 및 이용(필수)',
                            style: TextStyle(fontSize: 14.sp))
                      ],
                    ),
                    Text(
                      '보기',
                      style:
                          TextStyle(color: ColorCode.grey60, fontSize: 12.sp),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    GestureDetector(
                        onTap: _ssoRegisterNotifier.onTapAdCheckBox,
                        child: Consumer<SsoRegisterNotifier>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  SizedBox(
                            child: _ssoRegisterNotifier.adCheck
                                ? SvgPicture.asset(
                                    IconPath.iconCheckBoxSolidSelected)
                                : SvgPicture.asset(
                                    IconPath.iconCheckBoxDefault),
                            width: 18.w,
                            height: 18.w,
                          ),
                        )),
                    SizedBox(width: 7.w),
                    Text('광고성 문자 수신 여부(선택)', style: TextStyle(fontSize: 14.sp))
                  ],
                ),
              ],
            ),
            Consumer<SsoRegisterNotifier>(
                builder: (BuildContext context, value, Widget? child) =>
                    registerBtn())
          ],
        ),
      ),
    );
  }

  Widget registerBtn() {
    return _ssoRegisterNotifier.serviceCheck && _ssoRegisterNotifier.infoCheck &&
      _ssoRegisterNotifier.kioskState
        ? CustomButton.stretchTextBtnGreen50White(
            text: "회원가입", onPressed: () => _ssoRegisterNotifier.pressRegisterBtn(context))
        : CustomButton.stretchTextBtnDisabledGreen(text: "회원가입");
  }
}
