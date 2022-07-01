import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  void failCertification(
      {required BuildContext context, required String title}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: Text(title,
                        style: TextStyle(fontSize: 14.sp, height: 1.4.sp))),
                SizedBox(height: 4.h)
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 95.w),
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text("확인",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4.sp))),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  void flutterDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            //Dialog Main Title
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 24.h),
                    child: Text(title,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700))),
                SizedBox(height: 4.h)
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  content,
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.sp, horizontal: 47.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(fontSize: 14.sp, height: 1.4.sp),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.sp, horizontal: 47.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, RoutePath.registerConsentPage);
                          },
                          child: Text(
                            '확인',
                            style: TextStyle(
                                fontSize: 14.sp,
                                height: 1.4.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50),
                          )),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }
}
