import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/notifier/forgot/forgot_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants/color_code.dart';
import 'forgot_id_screen.dart';
import 'forgot_pwd_screen.dart';
import 'forgot_reset_pwd_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  late ForgotNotifier _forgotNotifier;

  @override
  void initState() {
    super.initState();
    _forgotNotifier = context.read<ForgotNotifier>();
  }

  @override
  void dispose() {
    _forgotNotifier.timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;

    Map<String, dynamic> argsData = args as Map<String,dynamic>;

    _forgotNotifier.screenState = argsData['screenState'] as ScreenState;

    _forgotNotifier.resetPwd = argsData['resetPwd'] as bool;

    if (argsData['memberIndex'] != null) {
      _forgotNotifier.findPwdMemberIndex = argsData['memberIndex'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.customAppBar(
          title: '계정찾기',
          createLeadingIcon: true,
          onPressed: () => Navigator.pop(context),
        ),
        body: content());
  }

  Widget content() {
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.only(top: 8.h, left: 24.w, right: 24.w, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [tabBar(), SizedBox(height: 34.h), innerContent()],
        ),
      ),
    );
  }

  // 아이디 찾기 / 비밀번호 찾기 / 비밀번호 재설정 골라줌

  Widget tabBar() {
    return Container(
        decoration: BoxDecoration(
            color: ColorCode.grey30, borderRadius: BorderRadius.circular(48)),
        padding: EdgeInsets.all(5.r),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: _forgotNotifier.onPressedFindIdBtn,
              child: Consumer<ForgotNotifier>(
                  builder: (BuildContext context, value, Widget? child) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          color: _forgotNotifier.screenState == ScreenState.id
                              ? ColorCode.white
                              : ColorCode.grey30,
                        ),
                        height: 38.h,
                        child: Center(
                            child: Text(
                          '아이디',
                          style: _forgotNotifier.screenState == ScreenState.id
                              ? const TextStyle(fontWeight: FontWeight.w700)
                              : const TextStyle(color: ColorCode.grey60),
                        )),
                      )),
            )),
            Expanded(
                child: GestureDetector(
                    onTap: _forgotNotifier.onPressedFindPwdBtn,
                    child: Consumer<ForgotNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            Container(
                              decoration: BoxDecoration(
                                color:  _forgotNotifier.screenState == ScreenState.pwd
                                    ? ColorCode.white
                                    : ColorCode.grey30,
                                borderRadius: BorderRadius.circular(48),
                              ),
                              height: 38.h,
                              child: Center(
                                  child: Text(
                                '비밀번호',
                                style: _forgotNotifier.screenState ==
                                            ScreenState.pwd
                                    ? const TextStyle(fontWeight: FontWeight.w700)
                                    : const TextStyle(color: ColorCode.grey60)
                              )),
                            )))),
          ],
        ));
  }

  Widget innerContent() {
    return Consumer<ForgotNotifier>(
        builder: (BuildContext context, value, Widget? child) {
      switch (_forgotNotifier.screenState) {
        case ScreenState.id:
          return const FindIdScreen();
        case ScreenState.pwd:
          return _forgotNotifier.resetPwd ? const ResetPwdScreen() : const FindPwdScreen();
      }
    });
  }
}
