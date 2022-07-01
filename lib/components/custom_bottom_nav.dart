



import 'package:comepass/notifier/main/bottom_nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants/color_code.dart';
import '../constants/icon_path.dart';

class CustomBottomNav extends StatelessWidget {
  BottomNavNotifier bottomNavNotifier;
  CustomBottomNav({Key? key,required this.bottomNavNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xff0000000).withOpacity(0.3),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: Consumer<BottomNavNotifier>(
            builder: (BuildContext context, value, Widget? child) => Theme(
              data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                    color: ColorCode.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500),
                selectedItemColor: Colors.black,
                unselectedLabelStyle: TextStyle(
                  color: ColorCode.grey70,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                currentIndex: bottomNavNotifier.bottomNavCurrentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: bottomNavNotifier.bottomNav,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                        width: 24.w,
                        height: 24.w,
                        padding: EdgeInsets.all(4.sp),
                        child:
                        SvgPicture.asset(IconPath.bottomNavHomeDisabled,color: ColorCode.grey70)),
                    activeIcon: Container(
                        width: 24.w,
                        height: 24.w,
                        padding: EdgeInsets.all(4.sp),
                        child: SvgPicture.asset(IconPath.bottomNavHome)),
                    label: "홈",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: EdgeInsets.all(4.sp),
                      child:
                      SvgPicture.asset(IconPath.bottomNavShopListDisabled,color: ColorCode.grey70),
                    ),
                    activeIcon: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: EdgeInsets.all(4.sp),
                      child: SvgPicture.asset(IconPath.bottomNavShopList),
                    ),
                    label: "매장목록",
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(width: 24.w, height: 24.w),
                    label: "나의 QR",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                        width: 24.w,
                        height: 24.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 7.sp, horizontal: 3.sp),
                        child:
                        SvgPicture.asset(IconPath.bottomNavTicketDisabled,color: ColorCode.grey70)),
                    activeIcon: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: EdgeInsets.symmetric(
                          vertical: 7.sp, horizontal: 3.sp),
                      child: SvgPicture.asset(IconPath.bottomNavTicket),
                    ),
                    label: "내이용권",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: const EdgeInsets.all(3),
                      child:
                      SvgPicture.asset(IconPath.bottomNavSettingDisabled,color: ColorCode.grey70),
                    ),
                    activeIcon: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: EdgeInsets.all(3.sp),
                      child: SvgPicture.asset(IconPath.bottomNavSetting),
                    ),
                    label: "설정",
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
