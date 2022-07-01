import 'package:comepass/components/custom_button.dart';
import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/constants/input_formatter.dart';
import 'package:comepass/notifier/forgot/forgot_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(
            children: [
              CustomTextField(
                styleHandling: false,
                controller: _forgotNotifier.findIdNameTextFieldController,
                hintText: '이름',
                returnState: _forgotNotifier.findIdNameValidator,
                type: "name",
              ),
              SizedBox(height: 18.h),
              CustomTextField(
                  styleHandling: false,
                  maxLength: 10,
                  inputFormatters: [
                    BirthTextInputFormatter(),
                    FilteringTextInputFormatter.allow(RegExp('[0-9|\s]')),
                  ],
                  controller: _forgotNotifier.findIdBirthTextFieldController,
                  hintText: '생년월일 8자리',
                  type: "birth",
                  returnState: _forgotNotifier.findIdBirthValidator),
              SizedBox(height: 18.h),
              CustomTextField(
                  styleHandling: false,
                  type: 'phone',
                  controller: _forgotNotifier.findIdPhoneTextFieldController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    CustomInputFormatter(),
                  ],
                  hintText: '0000 0000',
                  maxLength: 9,
                  prefixIcon: Text('010 ',
                      style: TextStyle(fontSize: 14.sp, height: 1.4.sp)),
                  returnState: _forgotNotifier.findIdPhoneValidator),
              SizedBox(height: 34.h),
            ],
          ),
          Consumer<ForgotNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  findIdBtn())
        ]));
  }

  findIdBtn() {
    return _forgotNotifier.findIdNameCheck &&
            _forgotNotifier.findIdPhoneCheck &&
            _forgotNotifier.findIdBirthCheck
        ? CustomButton.stretchTextBtnGreen50White(
            text: '아이디 찾기',
            onPressed: () => _forgotNotifier.pressFindIdBtn(context))
        : CustomButton.stretchTextBtnDisabledGreen(text: '아이디 찾기');
  }
}
