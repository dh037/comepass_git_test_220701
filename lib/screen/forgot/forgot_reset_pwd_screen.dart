import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/notifier/forgot/forgot_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../constants/color_code.dart';
import '../../constants/icon_path.dart';

class ResetPwdScreen extends StatefulWidget {
  const ResetPwdScreen({Key? key}) : super(key: key);

  @override
  State<ResetPwdScreen> createState() => _ResetPwdScreenState();
}

class _ResetPwdScreenState extends State<ResetPwdScreen> {
  late ForgotNotifier _forgotNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                  styleHandling: true,
                  hintText: '새 비밀번호',
                  obscureText: true,
                  controller: _forgotNotifier.resetPwdTextFieldController,
                  onChanged: _forgotNotifier.resetPwdValidator
              ),
              SizedBox(height: 4.h),
              Consumer<ForgotNotifier>(
                  builder: (BuildContext context, value, Widget? child) => Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: SvgPicture.asset(
                                IconPath.iconCheckmarkDerault,
                                color:
                                    _forgotNotifier.resetPwdTextFieldInputString
                                        ? ColorCode.green50
                                        : ColorCode.grey50),
                          ),
                          Text('영문+숫자+특수문자',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: _forgotNotifier
                                          .resetPwdTextFieldInputString
                                      ? ColorCode.green50
                                      : ColorCode.grey50)),
                          SizedBox(width: 4.w),
                          SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: SvgPicture.asset(
                                IconPath.iconCheckmarkDerault,
                                color: _forgotNotifier.resetPwdTextField8orMore
                                    ? ColorCode.green50
                                    : ColorCode.grey50),
                          ),
                          Text('8자 이상',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      _forgotNotifier.resetPwdTextField8orMore
                                          ? ColorCode.green50
                                          : ColorCode.grey50)),
                          SizedBox(width: 4.w),
                          SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: SvgPicture.asset(
                                IconPath.iconCheckmarkDerault,
                                color: _forgotNotifier.resetPwdTextField20ofLess
                                    ? ColorCode.green50
                                    : ColorCode.grey50),
                          ),
                          Text('20자 이하',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      _forgotNotifier.resetPwdTextField20ofLess
                                          ? ColorCode.green50
                                          : ColorCode.grey50)),
                          SizedBox(width: 4.w),
                        ],
                      )),
              SizedBox(height: 18.h),
              CustomTextField(
                  styleHandling: true,
                  hintText: '새 비밀번호 확인',
                  obscureText: true,
                  controller:
                      _forgotNotifier.resetPwdConfirmTextFieldController,
                  onChanged: _forgotNotifier.resetPwdConfirmValidator),
              SizedBox(height: 4.h),
              Consumer<ForgotNotifier>(
                  builder: (BuildContext context, value, Widget? child) => Row(
                        children: [
                          SizedBox(
                            width: 17.w,
                            height: 17.w,
                            child: SvgPicture.asset(
                                IconPath.iconCheckmarkDerault,
                                color: _forgotNotifier.resetPwdTextFieldConfirm
                                    ? ColorCode.green50
                                    : ColorCode.grey50),
                          ),
                          Text('비밀번호와 동일',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      _forgotNotifier.resetPwdTextFieldConfirm
                                          ? ColorCode.green50
                                          : ColorCode.grey50)),
                        ],
                      )),
            ],
          ),
          Consumer<ForgotNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  resetPwdBtn())
        ],
      ),
    );
  }

  resetPwdBtn() {
    return _forgotNotifier.resetPwdTextFieldInputString &&
            _forgotNotifier.resetPwdTextField20ofLess &&
            _forgotNotifier.resetPwdTextField8orMore &&
            _forgotNotifier.resetPwdTextFieldConfirm
        ? CustomButton.stretchTextBtnGreen50White(
            text: "비밀번호 재설정", onPressed: () => _forgotNotifier.pressResetPwdBtn(context))
        : CustomButton.stretchTextBtnDisabledGreen(text: '비밀번호 재설정');
  }
}
