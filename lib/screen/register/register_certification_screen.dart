import 'dart:convert';

import 'package:comepass/components/cupertino_progressbar.dart';
import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/input_formatter.dart';
import 'package:comepass/data/model/member_regist.dart';
import 'package:comepass/notifier/register/register_certification_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';

class RegisterCertificationScreen extends StatefulWidget {
  const RegisterCertificationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCertificationScreen> createState() =>
      _RegisterCertificationScreenState();
}

class _RegisterCertificationScreenState
    extends State<RegisterCertificationScreen> {
  late RegisterCertificationNotifier _registerCertificationNotifier;

  @override
  void initState() {
    super.initState();
    _registerCertificationNotifier =
        context.read<RegisterCertificationNotifier>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;

    _registerCertificationNotifier.memberRegist = args as MemberRegist;
  }

  @override
  void dispose() {
    super.dispose();
    _registerCertificationNotifier.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
          createLeadingIcon: true,
          onPressed: () {
            Navigator.pop(context);
          }),
      body: content(),
    );
  }

  content() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomCupertinoProgressbar(value: 0.25),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.h),
                    Text(
                      "전화번호를 입력하고\n문자로 전송된 인증번호를 입력해주세요",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.4.sp),
                    ),
                    SizedBox(height: 50.h),
                    Consumer<RegisterCertificationNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          CustomTextField(
                        styleHandling: true,
                        controller: _registerCertificationNotifier
                            .phoneTextFieldController,
                        maxLength: 9,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          CustomInputFormatter()
                        ],
                        suffixIcon: certificationBtn(),
                        hintText: '0000 0000',
                        prefixIcon: Text(
                          '010 ',
                          style: TextStyle(fontSize: 14.sp, height: 1.4.sp),
                        ),
                        onChanged:
                            _registerCertificationNotifier.phoneValidator,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Consumer<RegisterCertificationNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Offstage(
                        offstage: !_registerCertificationNotifier
                            .pressCertificationBtn,
                        child: CustomTextField(
                          styleHandling: true,
                          controller: _registerCertificationNotifier
                              .certificationCodeTextFieldController,
                          suffixIcon:
                              Text(_registerCertificationNotifier.timerString),
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          hintText: '인증번호 6자리',
                          onChanged: _registerCertificationNotifier
                              .certificationCodeValidator,
                          errorText: _registerCertificationNotifier.errorString,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Consumer<RegisterCertificationNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  confirmBtn())
        ],
      ),
    );
  }

  certificationBtn() {
    if (_registerCertificationNotifier.phoneState) {
      return CustomButton.smallTextBtnGreen0Green50(
        text: _registerCertificationNotifier.certificationBtnText,
        onPressed: _registerCertificationNotifier.certificationBtn,
      );
    } else {
      return CustomButton.smallTextBtnDisabledGrey(text: '인증요청');
    }
  }

  Widget confirmBtn() {
    if (_registerCertificationNotifier.phoneState &&
        _registerCertificationNotifier.certificationCodeState) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
        child: CustomButton.stretchTextBtnGreen50White(
            text: "확인",
            onPressed: () =>
                _registerCertificationNotifier.pressConfirmBtn(context)),
      );
    } else {
      return Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
          child: CustomButton.stretchTextBtnDisabledGreen(text: '확인'));
    }
  }
}
