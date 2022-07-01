import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/data/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../constants/input_formatter.dart';
import '../../notifier/forgot/forgot_notifier.dart';

class FindPwdScreen extends StatefulWidget {
  const FindPwdScreen({Key? key}) : super(key: key);

  @override
  State<FindPwdScreen> createState() => _FindPwdScreenState();
}

class _FindPwdScreenState extends State<FindPwdScreen> {
  late ForgotNotifier _forgotNotifier;

  @override
  void initState() {
    super.initState();
    _forgotNotifier = context.read<ForgotNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Column(
            children: [
              CustomTextField(
                  styleHandling: false,
                  returnState: _forgotNotifier.findPwdIdValidator,
                  controller: _forgotNotifier.findPwdIdTextFieldController,
                  type: "id",
                  hintText: '아이디'),
              SizedBox(height: 18.h),
              CustomTextField(
                  styleHandling: false,
                  returnState: _forgotNotifier.findPwdNameValidator,
                  controller: _forgotNotifier.findPwdNameTextFieldController,
                  type: "name",
                  hintText: '이름'),
              SizedBox(height: 12.h),
              Consumer<ForgotNotifier>(
                  builder: (BuildContext context, value, Widget? child) =>
                      CustomTextField(
                        styleHandling: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          CustomInputFormatter(),
                        ],
                        suffixIcon: certificationBtn(),
                        maxLength: 9,
                        controller:
                            _forgotNotifier.findPwdPhoneTextFieldController,
                        hintText: '0000 0000',
                        prefixIcon: Text('010 ',
                            style: TextStyle(fontSize: 14.sp, height: 1.4.sp)),
                        onChanged: _forgotNotifier.findPwdPhoneValidator,

                      )),
              SizedBox(height: 18.h),
              Consumer<ForgotNotifier>(
                  builder: (BuildContext context, value, Widget? child) =>
                      Offstage(
                          offstage:
                              !_forgotNotifier.isOnPressedCertificationBtn,
                          child: CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            ],
                            styleHandling: true,
                            errorText: _forgotNotifier.errorText,
                            maxLength: 6,
                            focusedBorderColorCursorColor: _forgotNotifier.certificationCodeTextFieldFocusedBorderColorCursorColor,
                            borderColor: _forgotNotifier.certificationCodeTextFieldBorderColor,
                            hintText: "인증번호 6자리",
                            suffixIcon: Text(_forgotNotifier.timerString),
                            controller: _forgotNotifier
                                .findPwdCertificationCodeTextFieldController,
                            onChanged: _forgotNotifier.findPwdCertificationCodeValidator,
                          ))),
            ],
          ),
          Consumer<ForgotNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  findPwdBtn())
        ]));
  }

  Widget certificationBtn() {
    return _forgotNotifier.findPwdPhoneCheck
        ? CustomButton.smallTextBtnGreen0Green50(
            text: _forgotNotifier.certificationBtnText,
            onPressed: () => _forgotNotifier.certificationBtn(context))
        : CustomButton.smallTextBtnDisabledGrey(text: '인증요청');

    // Text('tt') : Text('ss');
  }

  Widget findPwdBtn() {
    return _forgotNotifier.findPwdIdCheck &&
            _forgotNotifier.findPwdNameCheck &&
            _forgotNotifier.findPwdPhoneCheck &&
            _forgotNotifier.findPwdCertificationCodeCheck
        ? CustomButton.stretchTextBtnGreen50White(
            text: "비밀번호 찾기",
            onPressed: () => _forgotNotifier.pressFindPwdBtn(context))
        : CustomButton.stretchTextBtnDisabledGreen(text: "비밀번호 찾기");
  }
}
