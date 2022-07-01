import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/color_code.dart';
import '../constants/icon_path.dart';

class CustomSearhAppBar {
  static PreferredSizeWidget? customSearchAppBar(
          {void Function()? onPressed}) =>
      AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 24.w,
                height: 24.w,
                child: SvgPicture.asset(IconPath.iconArrowForward,
                    fit: BoxFit.fill)),
            SizedBox(width: 4.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    left: 8.w, right: 8.w, top: 6.h, bottom: 6.h),
                decoration: BoxDecoration(
                    color: ColorCode.grey30,
                    borderRadius: BorderRadius.circular(4)),
                height: 32.h,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorCode.grey30,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Container(
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(IconPath.iconSearch,
                              fit: BoxFit.fill, color: ColorCode.grey60)),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: TextField(
                          cursorColor: ColorCode.green50,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              isDense: true,
                              hintText: "주소, 매장이름 등으로 검색해보세요",
                              hintStyle: TextStyle(
                                  color: ColorCode.grey60,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: SizedBox.shrink(),
        actions: [],
      );
}
