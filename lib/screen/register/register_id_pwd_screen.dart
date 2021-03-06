import 'package:comepass/components/custom_button.dart';
import 'package:comepass/components/custom_text_field.dart';
import 'package:comepass/notifier/register/register_id_pwd_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../components/cupertino_progressbar.dart';
import '../../components/custom_appbar.dart';
import '../../constants/color_code.dart';
import '../../constants/icon_path.dart';
import '../../data/model/member_regist.dart';

class RegisterIdPwdScreen extends StatefulWidget {
  const RegisterIdPwdScreen({Key? key}) : super(key: key);

  @override
  State<RegisterIdPwdScreen> createState() => _RegisterIdPwdScreenState();
}

class _RegisterIdPwdScreenState extends State<RegisterIdPwdScreen> {
  late RegisterIdPwdNotifier _registerIdPwdNotifier;

  @override
  void initState() {
    super.initState();
    _registerIdPwdNotifier = context.read<RegisterIdPwdNotifier>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;
    _registerIdPwdNotifier.memberRegist = args as MemberRegist;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: CustomAppBar.customAppBar(
        createLeadingIcon: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
              const CustomCupertinoProgressbar(value: 0.5),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 42.h),
                    Text(
                      '???????????? ???????????????\n??????????????????',
                      style: TextStyle(
                          height: 1.4.sp,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 40.h),
                    Consumer<RegisterIdPwdNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            CustomTextField(
                              styleHandling: true,
                              suffixIcon: idSuffixIcon(),
                              controller: _registerIdPwdNotifier.idTextFieldController,
                              hintText: '?????????',
                              onChanged: _registerIdPwdNotifier.idValidation,
                            )),
                    SizedBox(height: 4.h),
                    Consumer<RegisterIdPwdNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Row(
                        children: [
                          SizedBox(
                              width: 17.w,
                              height: 17.w,
                              child: Consumer<RegisterIdPwdNotifier>(
                                builder: (BuildContext context, value,
                                        Widget? child) =>
                                    SvgPicture.asset(
                                        IconPath.iconCheckmarkDerault,
                                        color:
                                            _registerIdPwdNotifier.idInputString
                                                ? ColorCode.green50
                                                : ColorCode.grey50),
                              )),
                          Consumer<RegisterIdPwdNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  Text('??????+????????????',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: _registerIdPwdNotifier
                                                  .idInputString
                                              ? ColorCode.green50
                                              : ColorCode.grey50))),
                          SizedBox(width: 4.w),
                          SizedBox(
                              width: 17.w,
                              height: 17.w,
                              child: Consumer<RegisterIdPwdNotifier>(
                                builder: (BuildContext context, value,
                                        Widget? child) =>
                                    SvgPicture.asset(
                                        IconPath.iconCheckmarkDerault,
                                        color: _registerIdPwdNotifier.id5orMore
                                            ? ColorCode.green50
                                            : ColorCode.grey50),
                              )),
                          Consumer<RegisterIdPwdNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  Text('5??? ??????',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color:
                                              _registerIdPwdNotifier.id5orMore
                                                  ? ColorCode.green50
                                                  : ColorCode.grey50))),
                          SizedBox(width: 4.w),
                          SizedBox(
                              width: 17.w,
                              height: 17.w,
                              child: Consumer<RegisterIdPwdNotifier>(
                                builder: (BuildContext context, value,
                                        Widget? child) =>
                                    SvgPicture.asset(
                                        IconPath.iconCheckmarkDerault,
                                        color: _registerIdPwdNotifier.id12ofLess
                                            ? ColorCode.green50
                                            : ColorCode.grey50),
                              )),
                          Consumer<RegisterIdPwdNotifier>(
                              builder: (BuildContext context, value,
                                      Widget? child) =>
                                  Text('12??? ??????',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color:
                                              _registerIdPwdNotifier.id12ofLess
                                                  ? ColorCode.green50
                                                  : ColorCode.grey50))),
                          SizedBox(width: 4.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Consumer<RegisterIdPwdNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            CustomTextField(
                                styleHandling: true,
                                obscureText: true,
                                suffixIcon: pwdSuffixIcon(),
                                controller:
                                    _registerIdPwdNotifier.pwdTextFieldController,
                                hintText: '????????????',
                                onChanged:
                                    _registerIdPwdNotifier.pwdValidation)),
                    SizedBox(height: 4.h),
                    Consumer<RegisterIdPwdNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            Row(
                              children: [
                                SizedBox(
                                  width: 17.w,
                                  height: 17.w,
                                  child: SvgPicture.asset(
                                      IconPath.iconCheckmarkDerault,
                                      color:
                                          _registerIdPwdNotifier.pwdInputString
                                              ? ColorCode.green50
                                              : ColorCode.grey50),
                                ),
                                Text('??????+??????+????????????',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: _registerIdPwdNotifier
                                                .pwdInputString
                                            ? ColorCode.green50
                                            : ColorCode.grey50)),
                                SizedBox(width: 4.w),
                                SizedBox(
                                  width: 17.w,
                                  height: 17.w,
                                  child: SvgPicture.asset(
                                      IconPath.iconCheckmarkDerault,
                                      color: _registerIdPwdNotifier.pwd8orMore
                                          ? ColorCode.green50
                                          : ColorCode.grey50),
                                ),
                                Text('8??? ??????',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: _registerIdPwdNotifier.pwd8orMore
                                            ? ColorCode.green50
                                            : ColorCode.grey50)),
                                SizedBox(width: 4.w),
                                SizedBox(
                                  width: 17.w,
                                  height: 17.w,
                                  child: SvgPicture.asset(
                                      IconPath.iconCheckmarkDerault,
                                      color: _registerIdPwdNotifier.pwd20ofLess
                                          ? ColorCode.green50
                                          : ColorCode.grey50),
                                ),
                                Text('20??? ??????',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: _registerIdPwdNotifier.pwd20ofLess
                                          ? ColorCode.green50
                                          : ColorCode.grey50,
                                    )),
                                SizedBox(width: 4.w),
                              ],
                            )),
                    SizedBox(height: 18.h),
                    Consumer<RegisterIdPwdNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            CustomTextField(
                              obscureText: true,
                              styleHandling: true,
                              suffixIcon: pwdConfirmSuffixIcon(),
                              controller:
                                  _registerIdPwdNotifier.pwdConfirmTextFieldController,
                              hintText: '???????????? ??????',
                              onChanged:
                                  _registerIdPwdNotifier.pwdConfirmValidation,
                            )),
                    SizedBox(height: 4.h),
                    Consumer<RegisterIdPwdNotifier>(
                        builder: (BuildContext context, value, Widget? child) =>
                            Row(
                              children: [
                                SizedBox(
                                  width: 17.w,
                                  height: 17.w,
                                  child: SvgPicture.asset(
                                      IconPath.iconCheckmarkDerault,
                                      color:
                                          _registerIdPwdNotifier.pwdConfirmCheck
                                              ? ColorCode.green50
                                              : ColorCode.grey50),
                                ),
                                Text('??????????????? ??????',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: _registerIdPwdNotifier
                                                .pwdConfirmCheck
                                            ? ColorCode.green50
                                            : ColorCode.grey50)),
                              ],
                            )),
                  ],
                ),
              )
            ],
          ),
          Consumer<RegisterIdPwdNotifier>(
              builder: (BuildContext context, value, Widget? child) =>
                  nextBtn(context))
        ],
      ),
    );
  }

  Widget verifiedIcon = SizedBox(
      width: 20.w,
      height: 20.w,
      child: SvgPicture.asset(
        IconPath.iconComplete,
      ));

  Widget? idSuffixIcon() {
    return _registerIdPwdNotifier.idInputString &&
            _registerIdPwdNotifier.id5orMore &&
            _registerIdPwdNotifier.id12ofLess
        ? verifiedIcon
        : null;
  }

  Widget? pwdSuffixIcon() {
    return _registerIdPwdNotifier.pwdInputString &&
            _registerIdPwdNotifier.pwd8orMore &&
            _registerIdPwdNotifier.pwd20ofLess
        ? verifiedIcon
        : null;
  }

  Widget? pwdConfirmSuffixIcon() {
    return _registerIdPwdNotifier.pwdConfirmCheck ? verifiedIcon : null;
  }

  Widget nextBtn(BuildContext context) {
    // ????????? ????????? ?????? ????????? ????????? ????????????
    var finalCheck = _registerIdPwdNotifier.finalValidation();

    if (finalCheck) {
      return Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
          child: CustomButton.stretchTextBtnGreen50White(
              text: '??????',
              onPressed: () => _registerIdPwdNotifier.pressNextBtn(context)));
    } else {
      return Padding(
          padding: EdgeInsets.only(bottom: 16.h, right: 24.w, left: 24.w),
          child: CustomButton.stretchTextBtnDisabledGreen(text: '??????'));
    }
  }
}
