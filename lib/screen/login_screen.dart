import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/notifier/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../constants/color_code.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginNotifier _loginNotifier;

  @override
  void initState() {
    super.initState();
    _loginNotifier = context.read<LoginNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.customAppBar(title: "LOGIN"),
        body: content(context));
  }

  Color borderColor = Colors.green;
  Color focusedBorderColor = Colors.greenAccent;

  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          _loginNotifier.idFocusNode.unfocus();
          _loginNotifier.pwdFocusNode.unfocus();
        },
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 50.h, left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    loginArea(),
                    SizedBox(height: 40.h),
                    snsLoginBtn(),
                    SizedBox(height: 52.h),
                    registerOutlinedBtn(),
                    SizedBox(height: 51.h),
                    findIdAndPwdBtn()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController c1 = TextEditingController();

  Widget loginArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<LoginNotifier>(
            builder: (BuildContext context, value, Widget? child) =>
                CustomTextField(
                  focusNode: _loginNotifier.idFocusNode,
                  controller: _loginNotifier.idTextFieldController,
                  borderColor: _loginNotifier.idTextFieldBorderColor,
                  focusedBorderColorCursorColor:
                      _loginNotifier.idTextFieldFocusBorderColorCursorColor,
                  hintText: '아이디',
                  styleHandling: true,
                )),
        SizedBox(height: 18.h),
        Consumer<LoginNotifier>(
            builder: (BuildContext context, value, Widget? child) =>
                CustomTextField(
                  focusNode: _loginNotifier.pwdFocusNode,
                  controller: _loginNotifier.pwdTextFieldController,
                  borderColor: _loginNotifier.pwdTextFieldBorderColor,
                  focusedBorderColorCursorColor:
                      _loginNotifier.pwdTextFieldFocusBorderColorCursorColor,
                  errorText: _loginNotifier.errorMessage,
                  hintText: '비밀번호',
                  styleHandling: true,
                )),
        SizedBox(height: 16.h),
        CustomButton.stretchTextBtnGreen50White(
            text: '로그인',
            onPressed: () => _loginNotifier.comepassLoginBtn(context)),
      ],
    );
  }

  Widget snsLoginBtn() {
    return Column(
      children: [
        const Text('SNS로 로그인·회원가입',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () => _loginNotifier.kakaoLoginBtn(context),
                child: Container(
                    padding: EdgeInsets.only(
                        right: 12.w, left: 12.w, top: 13.w, bottom: 12.63.w),
                    child: SvgPicture.asset(IconPath.iconKakao),
                    height: 44.w,
                    width: 44.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xffFEE500)))),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () => _loginNotifier.naverLoginBtn(context),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.w, horizontal: 14.w),
                  child: SvgPicture.asset(IconPath.iconNaver),
                  height: 44.w,
                  width: 44.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff03CF5D),
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget registerOutlinedBtn() {
    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: () => _loginNotifier.registerBtn(context),
          child: RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: "회원이 아니신가요?  ",
                  style: TextStyle(color: ColorCode.black)),
              TextSpan(
                  text: "회원가입하기",
                  style: TextStyle(
                      color: ColorCode.black, fontWeight: FontWeight.w700)),
            ]),
          )),
    );
  }

  Widget findIdAndPwdBtn() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _loginNotifier.findIdBtn(context),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(width: 1, color: ColorCode.greyBorder))),
              alignment: Alignment.center,
              height: 24.h,
              child: const Text(
                '아이디 찾기',
                style: TextStyle(color: ColorCode.grey70),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _loginNotifier.findPwdBtn(context),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(width: 0, color: ColorCode.greyBorder))),
              alignment: Alignment.center,
              height: 24.h,
              child: const Text(
                '비밀번호 찾기',
                style: TextStyle(color: ColorCode.grey70),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
