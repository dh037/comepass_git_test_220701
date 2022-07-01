import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/notifier/forgot/find_pwd_add_info_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../components/custom_text_field.dart';
import '../../constants/input_formatter.dart';

class FindPwdAddInfoScreen extends StatefulWidget {
  const FindPwdAddInfoScreen({Key? key}) : super(key: key);

  @override
  State<FindPwdAddInfoScreen> createState() => _FindPwdAddInfoScreenState();
}

class _FindPwdAddInfoScreenState extends State<FindPwdAddInfoScreen> {
  late FindPwdAddInfoNotifier _findPwdAddInfoNotifier;

  @override
  void initState() {
    super.initState();
    _findPwdAddInfoNotifier = context.read<FindPwdAddInfoNotifier>();
  }

  @override
  void dispose() {
    super.dispose();
    _findPwdAddInfoNotifier.timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.customAppBar(
          createLeadingIcon: true,
          // Navigator.popAndPushNamed(context, RoutePath.forgotPage,arguments: false);
          // Navigator.pop(context);
        ),
        body: content());
  }

  Widget content() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 24.w, left: 24.w, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('가입된 정보와 휴대전화번호가 다릅니다\n추가정보를 입력해주세요',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.4.sp)),
                  idAndPwdInputArea(),
                  SizedBox(height: 50.h),
                  otherInputArea()
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14.w,
                      height: 14.w,
                      padding: EdgeInsets.all(1.17.w),
                      child: SvgPicture.asset(IconPath.iconNotice),
                    ),
                    const SizedBox(width: 4),
                    // 임시 방편~
                    const Expanded(
                        child: Text('문제가 해결되지 않을 경우 관리자나 고객센터로 연락 바랍니다.',
                            style: TextStyle(
                                fontSize: 14, color: ColorCode.red50))),
                  ],
                ),
                SizedBox(height: 16.h),
                const SizedBox(height: 10),
                CustomButton.stretchTextBtnGreen50White(
                    text: '비밀번호 찾기',
                    onPressed: () =>
                        _findPwdAddInfoNotifier.findPwdBtn(context))
              ],
            )
          ],
        ),
      ),
    );
  }

  idAndPwdInputArea() {
    return Column(children: [
      SizedBox(height: 50.h),
      CustomTextField(
        styleHandling: false,
        controller: _findPwdAddInfoNotifier.idTextFieldController,
        hintText: '아이디',
        returnState: _findPwdAddInfoNotifier.idValidator,
        type: 'id',
      ),
      SizedBox(height: 18.h),
      CustomTextField(
        styleHandling: false,
        controller: _findPwdAddInfoNotifier.nameTextFieldController,
        hintText: '이름',
        returnState: _findPwdAddInfoNotifier.nameValidator,
        type: 'name',
      ),
    ]);
  }

  otherInputArea() {
    return Column(
      children: [
        CustomTextField(
          styleHandling: false,
          inputFormatters: [
            BirthTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9|\s]')),
          ],
          controller: _findPwdAddInfoNotifier.birthTextFieldController,
          hintText: '생년월일',
          returnState: _findPwdAddInfoNotifier.birthValidator,
          maxLength: 10,
          type: 'birth',
        ),
        SizedBox(height: 18.h),
        CustomTextField(
          styleHandling: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          type: "kiosk",
          obscureText: true,
          maxLength: 4,
          controller: _findPwdAddInfoNotifier.kioskCodeTextFieldController,
          hintText: '키오스크 출입코드',
          returnState: _findPwdAddInfoNotifier.kioskCodeValidator,
        ),
        SizedBox(height: 18.h),
        Consumer<FindPwdAddInfoNotifier>(
            builder: (BuildContext context, value, Widget? child) =>
                CustomTextField(
                  styleHandling: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    CustomInputFormatter()
                  ],
                  maxLength: 9,
                  controller: _findPwdAddInfoNotifier.phoneTextFieldController,
                  hintText: '0000 0000',
                  onChanged: _findPwdAddInfoNotifier.phoneValidator,
                  prefixIcon: Text('010 ',
                      style: TextStyle(fontSize: 14.sp, height: 1.4.sp)),
                  suffixIcon: certificationBtn(),
                )),
        SizedBox(height: 18.h),
        Consumer<FindPwdAddInfoNotifier>(
            builder: (BuildContext context, value, Widget? child) => Offstage(
                offstage: !_findPwdAddInfoNotifier.pressCertificationBtn,
                child: CustomTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  styleHandling: true,
                  maxLength: 6,
                  controller: _findPwdAddInfoNotifier
                      .certificationCodeTextFieldController,
                  suffixIcon: Text(_findPwdAddInfoNotifier.timerString),
                  hintText: '인증번호 6자리',
                ))),
      ],
    );
  }

  Widget certificationBtn() {
    return _findPwdAddInfoNotifier.phoneState
        ? CustomButton.smallTextBtnGreen0Green50(
            text: _findPwdAddInfoNotifier.certificationBtnText,
            onPressed: () => _findPwdAddInfoNotifier.certificationBtn(context))
        : CustomButton.smallTextBtnDisabledGrey(text: '인증요청');
  }
}
