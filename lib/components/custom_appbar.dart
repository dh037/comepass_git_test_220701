import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/icon_path.dart';

class CustomAppBar {
  static PreferredSizeWidget? customAppBar(
          {String? title,
          bool createLeadingIcon = false,
          void Function()? onPressed}) =>
      AppBar(
          elevation: 0,
          title: title == null
              ? null
              : Text(title, style: TextStyle(fontSize: 16.sp)),
          centerTitle: true,
          leading: createLeadingIcon
              ? IconButton(
                  onPressed: onPressed ?? (){},
                  icon: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: SvgPicture.asset(IconPath.iconArrowForward),
                  ),
                )
              : null);
}
