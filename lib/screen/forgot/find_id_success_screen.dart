import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FindIdSuccessScreen extends StatefulWidget {
  const FindIdSuccessScreen({Key? key}) : super(key: key);

  @override
  State<FindIdSuccessScreen> createState() => _FindIdSuccessScreenState();
}

class _FindIdSuccessScreenState extends State<FindIdSuccessScreen> {
  String? id;

  String? name;
  late final args;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      args = ModalRoute.of(context)!.settings.arguments;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
          title: "계정찾기",
          onPressed: () {
            // Navigator.popAndPushNamed(context, RoutePath.forgotPage,arguments: false);
            Navigator.pop(context);
          },
          createLeadingIcon: true),
      body: content(context),
    );
  }

  content(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 162.h),
                SvgPicture.asset(
                  IconPath.iconCheckBoxSolidSelected,
                  width: 60.w,
                  height: 60.w,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${args['name']}의 아이디는',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            height: 1.4.sp,
                            fontSize: 18.sp),
                      ),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '${args['id']}',
                            style: TextStyle(
                                color: ColorCode.green50,
                                fontSize: 18.sp,
                                height: 1.4.sp,
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text: "입니다.",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                height: 1.4.sp,
                                fontSize: 18.sp))
                      ])),
                      SizedBox(height: 4.h),
                      Text("정보 보호를 위해 아이디의 일부만 표시합니다.",
                          style: TextStyle(
                              color: ColorCode.grey70, fontSize: 12.sp))
                    ],
                  ),
                ),
              ],
            ),
            CustomButton.stretchTextBtnGreen50White(
                text: '로그인하기',
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
