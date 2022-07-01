import 'package:comepass/components/custom_button.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //           width: 40.w,
                //           height: 23.h,
                //           child: SvgPicture.asset(IconPath.logoLeftBlack)),
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(right: 11.w, left: 16.w, top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(IconPath.logoLeftBlack,
                          width: 40.w, height: 23.h),
                    ],
                  ),
                ),
                SizedBox(height: 105.h),
                Column(
                  children: [
                    SizedBox(
                        child: QrImage(data: "dddddd"),
                        width: 180.w,
                        height: 180.w),
                    SizedBox(height: 25.h),
                    Text("출입 QR코드 스캔",style: TextStyle(fontSize: 18.sp, height: 1.4.sp)),
                    SizedBox(height: 4.h),
                    Text("매장에 설치된 입 퇴실기로 스캔하세요",style: TextStyle(fontSize: 14.sp, height: 1.4.sp,color: ColorCode.grey70)),
                  ]
                ),


              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 16.h),
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, style: ElevatedButton.styleFrom(
                  primary: ColorCode.grey30,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ), child: Text("닫기",style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700,color: Colors.black)))
              ),
            )
          ],
        ),
      ),
    );
  }
}
