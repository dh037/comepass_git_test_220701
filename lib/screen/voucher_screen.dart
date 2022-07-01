import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  List shopData = ['컴패스 센텀점', '컴패스 연산점', '컴패스 수영광안점', '컴패스 기장점', '컴패스 해운대점'];
  List voucherData = [];

  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(title: "내이용권"),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return content();
          }
        },
      ),
    );
  }

  Widget content() {
    return haveVoucher();
  }

  noVoucher() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 88.h),
          SizedBox(
              width: 232.w,
              height: 190.h,
              child:
                  SvgPicture.asset(ImagePath.illustVoucher, fit: BoxFit.cover)),
          SizedBox(height: 24.h),
          Text(
            "현재 사용 가능한 이용권이 없습니다.",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            child: Text('스터디카페 보러가기',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp)),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // <-- Radius
                ),
                primary: ColorCode.green50,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                elevation: 0),
          )
        ],
      ),
    );
  }

  haveVoucher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12.h),
        VoucherTopBanner(
            shopData: shopData,
            onChanged: (value) {
              print(value);
            }),
        SizedBox(height: 36.h),
        Container(
          height: 170.h,
          padding: EdgeInsets.only(left: 5.w),
          child: PageView(
            controller: controller,
            children: [
              // 이용권 Type 1
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
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10.w)
              ],
            ),
            Row(
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff000000).withOpacity(0.1),
                  ),
                ),
                SizedBox(width: 10.w)
              ],
            ),
            Row(
              children: [
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff000000).withOpacity(0.1),
                  ),
                ),
                SizedBox(width: 10.w)
              ],
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('상세정보',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(flex : 1, child: Text("좌석위치",style: TextStyle(fontSize: 12.sp,color: ColorCode.grey60),)),
                    Expanded(flex : 3, child: Text("입실과 좌석선택은 키오스크를 이용하세요",style: TextStyle(fontSize: 12.sp)))
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(flex : 1, child: Text("남은시간",style: TextStyle(fontSize: 12.sp,color: ColorCode.grey60))),
                    Expanded(flex : 3, child: Text("1시간 30분",style: TextStyle(fontSize: 12.sp)))
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(flex : 1, child: Text("구매일",style: TextStyle(fontSize: 12.sp,color: ColorCode.grey60))),
                    Expanded(flex : 3, child: Text("2021년 04월 01일",style: TextStyle(fontSize: 12.sp)))
                  ],
                ),
              ],
            ))
      ],
    );
  }
}

class VoucherTopBanner extends StatefulWidget {
  List shopData;
  ValueChanged onChanged;

  VoucherTopBanner(
      {Key? key, required this.shopData, required this.onChanged})
      : super(key: key);

  @override
  State<VoucherTopBanner> createState() => _StateVoucherTopBanner();
}

class _StateVoucherTopBanner extends State<VoucherTopBanner> {
  late String choose;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choose = widget.shopData.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        ...widget.shopData
            .map((e) => Row(
                  children: [
                    if (widget.shopData.first == e) SizedBox(width: 24.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          choose = e;
                          widget.onChanged(e);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 14.w),
                        decoration: BoxDecoration(
                            color:
                                choose == e ? ColorCode.black : ColorCode.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: choose == e
                                    ? Colors.transparent
                                    : ColorCode.greyBorder)),
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: choose == e
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: choose == e
                                  ? ColorCode.white
                                  : ColorCode.black),
                        ),
                      ),
                    ),
                    widget.shopData.last == e
                        ? SizedBox(width: 24.w)
                        : SizedBox(width: 4.w)
                  ],
                ))
            .toList(),
      ]),
    );
  }
}
