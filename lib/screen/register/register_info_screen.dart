import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/input_formatter.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/data/regex.dart';
import 'package:comepass/notifier/register/register_info_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/cupertino_progressbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../data/model/member_regist.dart';

class RegisterInfoScreen extends StatefulWidget {
  const RegisterInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {
  late RegisterInfoNotifier _registerInfoNotifier;

  @override
  void initState() {
    super.initState();
    _registerInfoNotifier = context.read<RegisterInfoNotifier>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;
    _registerInfoNotifier.memberRegist = args as MemberRegist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: CustomAppBar.customAppBar(
          createLeadingIcon: true,
          onPressed: () {
            Navigator.pop(context);
          }),
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
              const CustomCupertinoProgressbar(value: 0.75),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.h),
                    Text('회원정보를\n입력해주세요',
                        style: TextStyle(
                            height: 1.4.sp,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 50.h),
                    CustomTextField(
                      styleHandling: false,
                      type: "name",
                      controller: _registerInfoNotifier.nameTextFieldController,
                      hintText: "이름",
                      returnState: _registerInfoNotifier.nameValidator,
                    ),
                    SizedBox(height: 18.h),
                    CustomTextField(
                      maxLength: 10,
                      styleHandling: false,
                      type: "birth",
                      controller:
                          _registerInfoNotifier.birthTextFieldController,
                      hintText: "생년월일 8자리 ex)2000 01 01",
                      returnState: _registerInfoNotifier.birthValidator,
                      inputFormatters: [BirthTextInputFormatter()],
                    ),
                    SizedBox(height: 18.h),
                    CustomTextField(
                      styleHandling: false,
                      type: "email",
                      controller:
                          _registerInfoNotifier.emailTextFieldController,
                      hintText: "이메일",
                      returnState: _registerInfoNotifier.emailValidator,
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorCode.grey30,
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: _registerInfoNotifier.onTapManRadioBtn,
                                  child: Consumer<RegisterInfoNotifier>(
                                    builder: (BuildContext context, value,
                                            Widget? child) =>
                                        Container(
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                          color: _registerInfoNotifier.gender ==
                                                  null
                                              ? ColorCode.grey30
                                              : _registerInfoNotifier.gender!
                                                  ? ColorCode.white
                                                  : ColorCode.grey30,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                          child: Text('남자',
                                              style: TextStyle(
                                                  color: _registerInfoNotifier
                                                              .gender ==
                                                          null
                                                      ? ColorCode.grey60
                                                      : _registerInfoNotifier
                                                              .gender!
                                                          ? ColorCode.black
                                                          : ColorCode.grey60,
                                                  fontWeight:
                                                      _registerInfoNotifier
                                                                  .gender ==
                                                              null
                                                          ? FontWeight.w400
                                                          : _registerInfoNotifier
                                                                  .gender!
                                                              ? FontWeight.w700
                                                              : FontWeight.w400,
                                                  fontSize: 14.sp))),
                                    ),
                                  ))),
                          Expanded(
                              child: GestureDetector(
                                  onTap:
                                      _registerInfoNotifier.onTapWomenRadioBtn,
                                  child: Consumer<RegisterInfoNotifier>(
                                    builder: (BuildContext context, value,
                                            Widget? child) =>
                                        Container(
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                          color: _registerInfoNotifier.gender ==
                                                  null
                                              ? ColorCode.grey30
                                              : _registerInfoNotifier.gender!
                                                  ? ColorCode.grey30
                                                  : ColorCode.white,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                          child: Text("여자",
                                              style: TextStyle(
                                                fontWeight:
                                                    _registerInfoNotifier
                                                                .gender ==
                                                            null
                                                        ? FontWeight.w400
                                                        : _registerInfoNotifier
                                                                .gender!
                                                            ? FontWeight.w400
                                                            : FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: _registerInfoNotifier
                                                            .gender ==
                                                        null
                                                    ? ColorCode.grey60
                                                    : _registerInfoNotifier
                                                            .gender!
                                                        ? ColorCode.grey60
                                                        : ColorCode.black,
                                              ))),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: _registerInfoNotifier.onTapParentalConsent,
                            child: Consumer<RegisterInfoNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  SizedBox(
                                child: _registerInfoNotifier.parentalConsent
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
                    Consumer<RegisterInfoNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            CustomTextField(
                              styleHandling: true,
                              maxLength: 12,
                              type: 'phone2',
                              enabled: _registerInfoNotifier.parentalConsent,
                              controller: _registerInfoNotifier
                                  .parentPhoneTextFieldController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9|\s]')),
                              ],
                              hintText: "보호자 연락처",
                            ))

                  ],
                ),
              )
            ],
          ),
          Consumer<RegisterInfoNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  nextBtn())
        ],
      ),
    );
  }

  Widget nextBtn() {
    return _registerInfoNotifier.nameState &&
            _registerInfoNotifier.birthState &&
            _registerInfoNotifier.emailState &&
            _registerInfoNotifier.gender != null
        ? Padding(
            padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
            child: CustomButton.stretchTextBtnGreen50White(
                text: "다음",
                onPressed: () => _registerInfoNotifier.pressNextBtn(context)))
        : Padding(
            padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
            child: CustomButton.stretchTextBtnDisabledGreen(text: "다음"));
  }
}
