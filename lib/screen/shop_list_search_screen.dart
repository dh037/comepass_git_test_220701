import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/color_code.dart';
import '../../constants/icon_path.dart';

class ShopListSearchScreen extends StatefulWidget {
  const ShopListSearchScreen({Key? key}) : super(key: key);

  @override
  State<ShopListSearchScreen> createState() =>
      _ShopListSearchScreenState();
}

class _ShopListSearchScreenState extends State<ShopListSearchScreen> {


  TextEditingController c1 = TextEditingController();
  List searchList = [
    '서울대점',
    '부산대점',
    '김해장유점',
    '해운대 장산점'
  ];

  deleteSearchList(int index) {
    setState((){
      searchList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                    width: 24.w,
                    height: 24.w,
                    child: SvgPicture.asset(IconPath.iconArrowForward,
                        fit: BoxFit.fill)),
              ),
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
                            autofocus: true,
                            controller: c1,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              Navigator.pop(context, c1.text);
                            },
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
                                    fontWeight: FontWeight.w400,

                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
      body: content(),
    );
  }

  content() {
    return Padding(
      padding:
          EdgeInsets.only(top: 36.h, left: 16.w, right: 16.w, bottom: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "최근검색어",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              Text("모두지우기",
                  style: TextStyle(fontSize: 11.sp, color: ColorCode.grey60))
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, index) => Container(

                      height: 32.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('검색어 ${searchList[index]}')),
                          GestureDetector(
                            onTap: (){
                              deleteSearchList(index);
                            },
                            child: Container(
                              padding: EdgeInsets.zero,
                              width: 16.w,
                              height: 16.w,
                              child: SvgPicture.asset(
                                IconPath.iconDelete,
                                color: ColorCode.grey50,
                                fit: BoxFit.fill,
                                width: 1.5.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                separatorBuilder: (_, index) => Container(height: 10.h),
                itemCount: searchList.length),
          )
        ],
      ),
    );
  }
}
