import 'package:comepass/components/custom_multi_select_chip.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:comepass/screen/shop_list_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../components/custom_select_chip.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({Key? key}) : super(key: key);

  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  List isUse = ['전체', '이용중'];
  List bookMark = ['전체', '즐겨찾기한 매장'];
  List area1 = ["전국", "서울", "대전", "대구", "부산", "울산"];

  List area2 = ["경기", "경남", "경북", "전남", "전북"];

  void bottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            padding: EdgeInsets.only(
                top: 18.h, bottom: 16.w + MediaQuery.of(context).padding.bottom, right: 16.w, left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.w,
                        ),
                        Text("검색필터",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700)),
                        Container(
                          width: 24.w,
                          height: 24.w,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(IconPath.iconDelete,
                                  fit: BoxFit.fill)),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('이용여부',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorCode.grey80)),
                        SizedBox(height: 4.h),
                        CustomSelectChip(
                          defaultChoice: "전체",
                          list: isUse,
                          onSelected: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('즐겨찾기',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorCode.grey80)),
                        SizedBox(height: 4.h),
                        CustomSelectChip(
                          defaultChoice: "전체",
                          list: bookMark,
                          onSelected: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('지역',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorCode.grey80)),
                        SizedBox(height: 4.h),
                        CustomMultiSelectChip(list: area1, onSelected: (value) {print(value);}),
                        SizedBox(height: 8.h),
                        CustomMultiSelectChip(list: area2, onSelected: (value) {print(value);}),
                      ],
                    )

                    //

                    //
                    // SizedBox(height: 32.h)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "초기화",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: ColorCode.greyBorder),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                          primary: ColorCode.white,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {print(1);},
                        child: const Text("선택완료"),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 13.h),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            primary: ColorCode.green50,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }



  String? searchResult;
  String searchText = '주소, 매장이름 등으로 검색해보세요';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ShopListSearchScreen()));
                      setState(() {
                        searchResult = result;
                        searchText = result;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: SvgPicture.asset(IconPath.iconSearch,
                                fit: BoxFit.fill, color: ColorCode.grey60)),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(searchText,
                              style: TextStyle(
                                  color: ColorCode.grey60,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  bottomSheet();
                },
                icon: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: SvgPicture.asset(IconPath.iconFilter)))
          ],
        ),
      ),
      body: content(context),
    );
  }

  content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (searchResult != null)
            searchResult == "우동"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text.rich(TextSpan(
                          text: searchResult,
                          style: TextStyle(
                              color: ColorCode.green50,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.4.sp),
                          children: [
                            TextSpan(
                                text: ' 검색결과는\n24개 입니다.',
                                style: TextStyle(color: Colors.black))
                          ])),
                      SizedBox(height: 20.h),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '검색결과가 없습니다.\n아래와 같이 검색해보세요.',
                        style: TextStyle(
                            color: ColorCode.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.4.sp),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
          searchResult == "우동"
              ? Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) => Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  width: 62.w,
                                  height: 62.w,
                                  child: Image.asset(
                                    ImagePath.shopImage,
                                    fit: BoxFit.fill,
                                  )),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text("컴패스 해운대동부센트레빌점",
                                        style: TextStyle(
                                            fontSize: 14.sp, height: 1.4.sp)),
                                    SizedBox(height: 2.h),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.black,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 3.h,
                                                bottom: 4.h,
                                                left: 5.w,
                                                right: 5.w),
                                            child: Text(
                                              '2km',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: ColorCode.grey30,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 3.h,
                                                bottom: 4.h,
                                                left: 5.w,
                                                right: 5.w),
                                            child: Text(
                                              '독서실',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Text("전체좌석 46석",
                                        style: TextStyle(
                                            color: ColorCode.grey60,
                                            fontSize: 12.sp)),
                                  ],
                                ),
                              )
                            ],
                          ),
                      separatorBuilder: (_, index) => SizedBox(height: 14.h),
                      itemCount: 4),
                )
              : Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '· 도로명 + 건물번호',
                      style: TextStyle(fontSize: 12.sp, height: 1.4.sp),
                    ),
                    Text('   예) 컴패스로 1길 3',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorCode.grey60,
                            height: 1.4.sp)),
                    SizedBox(height: 22.h),
                    Text(
                      '· 지역명 + 번지',
                      style: TextStyle(fontSize: 12.sp, height: 1.4.sp),
                    ),
                    Text('   예) 컴패스동 1-11',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorCode.grey60,
                            height: 1.4.sp)),
                    SizedBox(height: 22.h),
                    Text(
                      '· 건물명, 아파트명',
                      style: TextStyle(fontSize: 12.sp, height: 1.4.sp),
                    ),
                    Text('   예) 컴패스타워 101동',
                        style: TextStyle(
                            fontSize: 12.sp, color: ColorCode.grey60)),
                    SizedBox(height: 22.h),
                    Text(
                      '· 매장명',
                      style: TextStyle(fontSize: 12.sp, height: 1.4.sp),
                    ),
                    Text('   컴패스 스터디카페',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorCode.grey60,
                            height: 1.4.sp)),
                    SizedBox(height: 22.h),
                  ],
                )),
        ],
      ),
    );
  }
}
