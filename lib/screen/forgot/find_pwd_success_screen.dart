import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FindPwdSuccessScreen extends StatelessWidget {
  const FindPwdSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        title: "계정찾기",
        createLeadingIcon: true,
        onPressed: () {},
      ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24.w, left: 25.w, bottom: 16.h),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 162.h),
                    Container(
                      padding: EdgeInsets.all(20.sp),
                      height: 100.w,
                      width: 100.w,
                      child: SvgPicture.asset(
                        IconPath.iconCheckBoxSolidSelected,
                      ),
                    ),
                    Text(
                      '비밀번호가 재설정 되었습니다',
                      style: TextStyle(
                          fontSize: 18.sp,
                          height: 1.4.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '변경된 비밀번호로 로그인해주세요',
                      style: TextStyle(
                          color: ColorCode.grey70,
                          fontSize: 14.sp,
                          height: 1.4.sp),
                    ),
                  ],
                )
              ],
            ),
            CustomButton.stretchTextBtnGreen50White(
                text: "로그인하기",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutePath.loginPage, (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
