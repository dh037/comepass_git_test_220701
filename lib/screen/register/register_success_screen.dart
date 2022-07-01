import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        title: "회원가입"
      ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 100.h),
                SvgPicture.asset(ImagePath.registerSuccessImage),
                Text('회원가입 완료!',style: TextStyle(fontSize: 18.sp, height: 1.4.sp),),
                SizedBox(height: 4.h),
                Text('컴패스를 자유롭게 이용해보세요', style: TextStyle(fontSize: 14.sp, height: 1.4.sp,color: ColorCode.grey70))
              ],
            ),
            CustomButton.stretchOutlinedTextBtnGreen50(text: "홈으로" , onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, RoutePath.loginPage, (route) => false);
            })
          ],
        ),
      ),
    );
  }
}
