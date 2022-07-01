import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.w,
      width: 48.w,
      margin: EdgeInsets.only(top: 8.h),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutePath.qrScreen);
        },
        child: Container(
          height: 48.w,
          width: 48.w,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xff000000).withOpacity(0.08), width: 1.w),
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  colors: [Color(0xff2ECE95), Color(0xff1EAF8D)])),
          child: SvgPicture.asset(
            'assets/icon/Icon_QRcode.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
