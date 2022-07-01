import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_code.dart';

class CustomButton {
  static Widget stretchTextBtnGreen50White({
    required String text,
    required void Function()? onPressed,
  }) =>
      SizedBox(
          height: 48.h,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: ColorCode.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              primary: ColorCode.green50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ));

  static Widget stretchTextBtnDisabledGreen({
    required String text,
  }) =>
      SizedBox(
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              text,
              style: TextStyle(
                  color: ColorCode.disabledGreen,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              primary: ColorCode.disabledGrey,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ));

  static Widget stretchOutlinedTextBtnGreen50({
    required String text,
    required void Function()? onPressed
  }) => SizedBox(
    height: 48.h,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(
          width: 1,
          color: ColorCode.green50
        ),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Pretendard",
        ),

        primary: Colors.transparent,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: ColorCode.green50)),

    ),
  );

  static Widget smallTextBtnGreen0Green50(
          {required String text, required void Function()? onPressed}) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Pretendard"
              ),
              primary: ColorCode.green0,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 11.sp)),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: ColorCode.green50),
          ));

  static Widget smallTextBtnDisabledGrey({required String text}) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700),
              primary: ColorCode.disabledGreen,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 11.sp)),
          onPressed: () {},
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorCode.disabledGrey),
          ));
}
