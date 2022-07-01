import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
            debugShowCheckedModeBanner: false,
            home: MyPage(),
          );
        });
  }
}

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var _itemsView = GlobalKey();

  List data = ['dfdaf', 'dfadf', 'wqewqeqweq'];

  double? _stackHeight;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox stackRB =
          _itemsView.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _stackHeight = stackRB.size.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: my(context));
  }

  my(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              image: AssetImage(ImagePath.shopInfoImage))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20),
            Row(
              children: [
                SvgPicture.asset(IconPath.iconArrowForward)
              ],
            ),
            SizedBox(height: 240),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Column(
                children: [
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),
                  Text("dddd"),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  shopInfoContainer1(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "컴패스 우동점",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                    width: 24.h,
                    height: 24.h,
                    child: SvgPicture.asset(IconPath.iconHeart,
                        color: ColorCode.grey50))
              ],
            ),
          ),
          SizedBox(height: 29.h),
          Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 8.h, left: 8.w),
                    height: 56.w,
                    width: 100.h,
                    child: Text('운영시간',
                        style: TextStyle(
                            color: ColorCode.grey60, fontSize: 14.sp))),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 8.h, right: 8.w),
                  height: 56.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "일반좌석 AM10:00 ~ PM12:00",
                        style:
                            TextStyle(fontSize: 14.sp, color: ColorCode.grey80),
                      ),
                      Text(
                        "일반좌석 AM10:00 ~ PM12:00",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorCode.grey80,
                            height: 1.4.sp),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 8.h, left: 8.w),
                    height: 56.w,
                    width: 120.h,
                    child: Text('좌석표',
                        style: TextStyle(
                            color: ColorCode.grey60, fontSize: 14.sp))),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 8.h, right: 8.w),
                  height: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorCode.green0,
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.only(left: 6.w, bottom: 1.h, right: 4.w),
                        child: Text(
                          "좌석 100석>",
                          style: TextStyle(
                              color: ColorCode.green50,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.4.sp),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorCode.green0,
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                            EdgeInsets.only(left: 6.w, bottom: 1.h, right: 4.w),
                        child: Text(
                          "사물함 40칸>",
                          style: TextStyle(
                              color: ColorCode.green50,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.4.sp),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  youtube(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
              // Our background
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

