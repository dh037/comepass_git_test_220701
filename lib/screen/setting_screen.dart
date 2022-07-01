import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:comepass/notifier/main/update_notifier.dart';
import 'package:comepass/screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(title: "설정"),
      body: content(context),
    );
  }

  content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                            create: (_) => UpdateNotifier(),
                            child: UpdateScreen())));
              },
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(ImagePath.shopImage))),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '강아지님',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            Text(
                              'cutedog12@gmail.com',
                              style: TextStyle(
                                  height: 1.4.sp,
                                  fontSize: 12.sp,
                                  color: ColorCode.grey60),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24.w,
                      width: 24.w,
                      child: SvgPicture.asset(
                        IconPath.iconArrowNext,
                        color: ColorCode.grey60,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(
                            IconPath.iconLocation,
                            color: Colors.white,
                          )),
                      Text("위치설정",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp)),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(
                            IconPath.bottomNavTicket,
                            color: Colors.white,
                          )),
                      Text(" 결제내역",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp)),
                    ],
                  ))
                ],
              ),
            ),
          ),
          SizedBox(height: 38.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          "공지사항",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                    Container(
                        child: Text('이벤트', style: TextStyle(fontSize: 14.sp)),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                    Container(
                        child:
                            Text('자주 묻는 질문', style: TextStyle(fontSize: 14.sp)),
                        padding: EdgeInsets.symmetric(vertical: 14.h))
                  ],
                ),
                SizedBox(height: 24.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text("알림함", style: TextStyle(fontSize: 14.sp)),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                    Container(
                        child: Text('알림설정', style: TextStyle(fontSize: 14.sp)),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                  ],
                ),
                SizedBox(height: 24.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child:
                            Text("약관 및 정책", style: TextStyle(fontSize: 14.sp)),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                    Container(
                        child: Text('앱 버전 v 1.0.0',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: ColorCode.grey60,
                            )),
                        padding: EdgeInsets.symmetric(vertical: 14.h)),
                    SizedBox(height: 50.h),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
