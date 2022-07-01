import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/screen/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/color_code.dart';
import '../constants/icon_path.dart';
import '../constants/image_path.dart';
import '../notifier/main/home_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeNotifier _homeNotifier;
  PageController controller = PageController(viewportFraction: 0.9);

  late Map<String, dynamic> userData;
  late List<Map<String, dynamic>> voucherData;
  late List<Map<String, dynamic>> shopListData;
  late List<Map<String, dynamic>> eventBannerData;

  late List a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeNotifier = context.read<HomeNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FutureBuilder(
            future: Future.wait([
              _homeNotifier.getUserData(),
              _homeNotifier.getVoucherData(),
              _homeNotifier.getShopListData(),
              _homeNotifier.getEventBannerData(),

            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {

                return Center(child: CircularProgressIndicator());
              } else {
                List a = snapshot.data as List;
                userData = a[0];
                voucherData = a[1];
                shopListData = a[2];
                eventBannerData = a[3];
                return content(context);
              }
            }));
  }


  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.mainBgImage), fit: BoxFit.fill)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: EdgeInsets.only(right: 11.w, left: 16.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(ImagePath.logoTypeDefaultLeft,
                      width: 40.w, height: 23.h),
                  Stack(
                    children: [
                      SvgPicture.asset(IconPath.iconBell,
                          width: 40.w, height: 23.h, color: ColorCode.white),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: SvgPicture.asset(IconPath.iconBadgeDot,
                              width: 4.w, height: 4.h))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 51.h),
            Container(

              padding: EdgeInsets.only(right: 32.w, left: 17.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userData['address'] != null ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 172.w),
                            child: Text(userData['address'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorCode.green40,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(IconPath.iconLocationBtn,
                              width: 20.w, height: 20.h),
                        ],
                      ),
                      Container(
                        child: Text('${userData['name']}님',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                height: 1.4.sp,
                                color: ColorCode.grey50,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700)),
                        constraints: BoxConstraints(maxWidth: 146.w),
                      ),

                    ],
                  ) : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Container(
                        constraints: BoxConstraints(maxWidth: 172.w),
                        child: Text('내 위치를',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.4.sp,
                                color: ColorCode.grey50,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("추가하세요",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: ColorCode.grey50,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700)),
                            constraints: BoxConstraints(maxWidth: 146.w),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(IconPath.iconLocationBtnDisable,
                              width: 20.w, height: 20.h),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        child: Text("${userData['name']}님",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                color: ColorCode.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700)),
                        constraints: BoxConstraints(maxWidth: 146.w),
                      ),

                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => QrScreen()));
                    },
                    child: Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        color: ColorCode.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QrImage(
                        data: userData['qr'],
                        version: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 48.h),
            Container(
              height: 100.h,
              child: PageView(
                onPageChanged: _homeNotifier.voucherBanner,
                controller: controller,
                children: voucherData.map((e) {
                  return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: Container(
                          padding: EdgeInsets.only(left: 20.w),
                          decoration: BoxDecoration(
                            color: const Color(0xff000000).withOpacity(0.1),
                            border: Border(
                                left: const BorderSide(
                                    width: 3, color: ColorCode.green50),
                                top: BorderSide(
                                    color: const Color(0xff1affffff)
                                        .withOpacity(0.06),
                                    width: 2),
                                right: BorderSide(
                                    color: const Color(0xff1affffff)
                                        .withOpacity(0.06),
                                    width: 0.9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    e['shop'],
                                    style: TextStyle(
                                        color: ColorCode.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp),
                                  ),
                                  SizedBox(width: 4.w),
                                  if (e['type'] != null)
                                    ...e['type'].map((e) {
                                      return Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 4),
                                                color: e == "자유석"
                                                    ? ColorCode.green50
                                                    : ColorCode.white,
                                                child: Text(e,
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: e == "자유석"
                                                            ? Colors.white
                                                            : Colors.black))),
                                          ),
                                          SizedBox(width: 4.w)
                                        ],
                                      );
                                    })
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  ...e['time'].map((e2) {
                                    return Row(
                                      children: [
                                        Text(
                                          e2,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              height: 1.4.sp),
                                        ),
                                        if (e['time'].last != e2)
                                          Text(' / ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  height: 1.4.sp))
                                      ],
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(
                            right: 8.w,
                          )));
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),
            Consumer<HomeNotifier>(
                builder: (BuildContext context, value, Widget? child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      voucherData.length,
                      (index) => Container(
                        width: 6.w,
                        height: 6.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                            color:
                                _homeNotifier.voucherBannerDotIndicatorIndex ==
                                        index
                                    ? Colors.white
                                    : const Color(0xffFFFFFF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ))),
            SizedBox(height: 20.h),
          ]),
        ),
        SizedBox(height: 20.h),
        eventBanner(),
        SizedBox(height: 20.h),
        nearestStore(),
        SizedBox(height: 31.h)
      ]),
    );
  }

  Widget eventBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
          height: 72.h,
          child: Stack(children: [
            PageView(
              children: eventBannerData
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(e['image']))),
                      ))
                  .toList(),
              onPageChanged: _homeNotifier.eventBanner,
            ),
            Positioned(
                bottom: 8.h,
                right: 24.w,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff000000).withOpacity(0.2)),
                    child: Consumer<HomeNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Text.rich(
                        TextSpan(
                            text: '${_homeNotifier.eventBannerIndex + 1}',
                            // list. length
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: ColorCode.white,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: " / ${eventBannerData.length} ",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorCode.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                  text: '모두보기',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: ColorCode.white,
                                      fontWeight: FontWeight.w500))
                            ]),
                      ),
                    )))
          ]),
        ),
      ],
    );
  }

  Widget nearestStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '가까운 매장',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Text(
                    '더보기',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorCode.grey60),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -40.h,
                left: 9.5.w,
                child: Offstage(
                  offstage: userData['address'] != null ? true : false,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black,
                    ),
                    child: Text('위치정보를 추가하고 가까운 매장을 추천받으세요',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                )),
            Positioned(
                top: -12.h,
                left: 25.w,
                child: Offstage(
                  offstage: userData['address'] != null ? true : false,
                  child: ClipPath(
                    child: Container(
                      width: 8,
                      height: 8,
                      color: Colors.black,
                    ),
                    clipper: CustomClipPath(),
                  ),
                ))
          ],
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            SizedBox(width: 16.w),
            ...shopListData.map((e) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RoutePath.shopInfoScreen);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1.sp,
                                      color: const Color(0xff000000)
                                          .withOpacity(0.1)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e['shopImage']),
                                  )),
                              width: 128.w,
                              height: 128.w,
                            ),
                            Positioned(
                              right: 8.w,
                              top: 8.h,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 3.h, bottom: 4.h, right: 5.w, left: 5.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  "${e['distance']}거리",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          child: Text(
                            e['name'],
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                          constraints: BoxConstraints(maxWidth: 128.w),
                        ),
                        Text("전체좌석 ${e['sheetCount']}석",
                            style: TextStyle(
                                color: ColorCode.grey60, fontSize: 12.sp))
                      ],
                    ),
                  ),
                  shopListData.last != e
                      ? SizedBox(width: 8.w)
                      : const SizedBox.shrink()
                ],
              );
            }).toList(),
            SizedBox(width: 16.w),
          ]),
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
