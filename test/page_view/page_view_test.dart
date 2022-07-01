import 'package:comepass/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'page_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: (context, child) {
          return MaterialApp(
            home: MyPage(),
          );
        });
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ExpandablePageView(children: [
              Row(
                children: [
                  Container(
                    width: 312.w,
                    height: 170.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff2AC88F), Color(0xff2E938D)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 8.w),
                              child: Text(
                                "자유석",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xff000000).withOpacity(0.3),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 8.w),
                              child: Text(
                                "입실가능",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text('시간권(3시간)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              // 이용권 Type 2
              Row(
                children: [
                  Container(
                    width: 312.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff2AC88F), Color(0xff2E938D)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 8.w),
                                child: Text(
                                  "자유석",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text('시간권(3시간)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp))
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 48.h,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      print(1);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: 14.h, top: 14.h),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff000000)
                                              .withOpacity(0.3),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('외출하기',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          Container(
                                              width: 18.w,
                                              height: 18.w,
                                              child: SvgPicture.asset(
                                                IconPath.iconArrowNext,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      print(2);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: 14.h, top: 14.h),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff000000)
                                              .withOpacity(0.3),
                                          borderRadius: const BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('퇴실하기',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          Container(
                                              width: 18.w,
                                              height: 18.w,
                                              child: SvgPicture.asset(
                                                IconPath.iconArrowNext,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Positioned(
                                child: Center(
                                    child: Column(
                              children: [
                                SizedBox(height: 18.h),
                                Container(
                                  color: Colors.white.withOpacity(0.23),
                                  width: 1.w,
                                  height: 11.h,
                                ),
                              ],
                            )))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 이용권 Type 3
              Row(
                children: [
                  Container(
                    width: 312.w,
                    height: 170.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff4E9FFF), Color(0xff1A5BDB)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 8.w),
                          child: Text(
                            "스터디룸 A실",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text('3인 컨퍼런스룸(4시간)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              // 이용권 Type 4
              Row(
                children: [
                  Container(
                    width: 312.w,
                    height: 170.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff97A3B0), Color(0xff5E7A9B)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 8.w),
                          child: Text(
                            "입구사물함 45번",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text('사물함(28일)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              // 이용권 Type 5
              Row(
                children: [
                  Container(
                    width: 312.w,
                    height: 300.h,
                    padding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff97A3B0), Color(0xff5E7A9B)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 8.w),
                          child: Text(
                            "입구사물함 45번",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text('사물함(28일)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ])
          ],
        ),

      ),
    );
  }
}
