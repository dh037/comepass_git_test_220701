import 'package:comepass/components/custom_button.dart';
import 'package:comepass/components/custom_main_tabbar.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../notifier/main/shop_info_notifier.dart';

class ShopInfoScreen extends StatefulWidget {
  const ShopInfoScreen({Key? key}) : super(key: key);

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  ScrollController controller = ScrollController();
  Color iconColor = Colors.white;

  late ShopInfoNotifier _mainShopInfoNotifier;
  late PageController pageViewController;

  List shopImage = [
    "https://mblogthumb-phinf.pstatic.net/MjAyMDA2MjRfMTg2/MDAxNTkzMDAxNzcyNjU0.UUjT6y5N0RMERtbUZ7X9MVKJZHEkd8gKdrzAcxI_b3wg.sAzt0otPMG8vbA75NZ3L33qkeR58CRqsvQAN-dBI4MMg.JPEG.rever_moi/1593001772374.jpg?type=w800",
    "https://mblogthumb-phinf.pstatic.net/MjAyMTAxMDNfMTg1/MDAxNjA5NjQ3NTE1Njg0.PH6_O_bO7Gxqnx-YVE38_mqAf6yE1xOFNdTq8lXMsDIg.bk0lABvhSXNUKJBDTlTYa5F2hQg6R-nFqhmx0Nc8Tvog.JPEG.dsmsil/KakaoTalk_20201223_182540482_13.jpg?type=w800",
    "http://www.ujeil.com/news/photo/202109/285324_120930_1936.png",
    "https://cdn.nbntv.co.kr/news/photo/202105/927922_33063_511.png",
    "http://cdn.ksilbo.co.kr/news/photo/202110/914407_511921_5540.png"
  ];

  List<Map<String, dynamic>> data = [
    {
      "type": "자유석",
      "explain": "입실 할때 마다 자유롭게 원하는 좌석을 선택할 수 있어 합리적 이용이 가능합니다.",
      "typeList": ['자유석 시간권', '자유석 정기시간권', '자유석 기간권']
    },
    {
      "type": "프리미엄 자유석",
      "explain": "입실 할때 마다 자유롭게 좌석을 선택할 수 있어 합리적 이용이 가능합니다.",
    },
    {
      "type": "지정석",
      "explain":
          "원하는 자리를 선정해서 일정 기간동안 이용할 수 있습니다. 높은 집중력을 요구하는 학습이 필요할때 사용하기 좋습니다.",
      "typeList": ['가석', '나석', '다석']
    },
    {
      "type": "사물함",
      "explain": "개인 용품을 일정 기간 동안 보관할 수 있습니다.",
      'typeList': ['사물함']
    },
    {
      "type": "스터디룸",
      "explain": "스터디룸을 선택하고 예약할 수 있습니다.",
      "typeList": ['가나다룸']
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _mainShopInfoNotifier = context.read<ShopInfoNotifier>();
    controller.addListener(() {
      setState(() {
        controller.offset >= 284
            ? iconColor = Colors.black
            : iconColor = Colors.white;
      });
    });
    pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  width: 24.w,
                  height: 24.w,
                  margin: EdgeInsets.only(top: 20.h, left: 16.w),
                  padding: EdgeInsets.only(
                      left: 7.w, right: 9.w, bottom: 5.h, top: 5.h),
                  child: SvgPicture.asset(
                    IconPath.iconArrowForward,
                    color: iconColor,
                  )),
            )),
      ),
      extendBodyBehindAppBar: true,
      body: content(),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 이미지
          Stack(children: [
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> args = {
                  "shopImage": shopImage,
                  "pageIndex": _mainShopInfoNotifier.shopImagePageViewIndex
                };

                var pageIndex = await Navigator.pushNamed(
                    context, RoutePath.shopInfoImageDetailScreen,
                    arguments: args);
                int page = pageIndex as int;
                pageViewController.jumpToPage(page);
              },
              child: SizedBox(
                height: 300.h,
                child: Consumer<ShopInfoNotifier>(
                    builder: (BuildContext context, value, Widget? child) =>
                        PageView(
                            controller: pageViewController,
                            onPageChanged: _mainShopInfoNotifier.shopImage,
                            children: shopImage
                                .map((e) => Image.network(e, fit: BoxFit.fill))
                                .toList())),
              ),
            ),
            Positioned(
                bottom: 12.h,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Consumer<ShopInfoNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                shopImage.length,
                                (index) => Container(
                                  width: 6.w,
                                  height: 6.w,
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  decoration: BoxDecoration(
                                      color: _mainShopInfoNotifier
                                                  .shopImagePageViewIndex ==
                                              index
                                          ? Colors.white
                                          : const Color(0xffFFFFFF)
                                              .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              )),
                    )))
          ]),
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
                GestureDetector(
                  onTap: _mainShopInfoNotifier.toggleHeart,
                  child: Consumer<ShopInfoNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          SizedBox(
                              width: 24.h,
                              height: 24.h,
                              child: _mainShopInfoNotifier.heartIcon
                                  ? SvgPicture.asset(IconPath.iconHeartRed)
                                  : SvgPicture.asset(IconPath.iconHeart,
                                      color: ColorCode.grey50))),
                )
              ],
            ),
          ),
          SizedBox(height: 29.h),
          Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('운영시간',
                    style: TextStyle(color: ColorCode.grey60, fontSize: 14.sp)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "일반좌석 AM10:00 ~ PM12:00",
                      style:
                          TextStyle(fontSize: 14.sp, color: ColorCode.grey80),
                    ),
                    Text(
                      "스터디룸 AM10:00 ~ PM10:00",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorCode.grey80,
                          height: 1.4.sp),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('좌석표',
                    style: TextStyle(color: ColorCode.grey60, fontSize: 14.sp)),
                Expanded(
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
                )
              ],
            ),
          ),
          SizedBox(height: 34.h),
          CustomMainTabBar(
            onChanged: (value) => _mainShopInfoNotifier.mainTabBar(value),
          ),
          SizedBox(height: 17.sp),
          Consumer<ShopInfoNotifier>(
              builder: (BuildContext context, value, Widget? child) {
            switch (_mainShopInfoNotifier.tabBarState) {
              case "이용권구매":
                return ticket();
              case "가격안내":
                return price();
              case "정보":
                return info();
              default:
                return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }

  Widget ticket() {
    return Container(
      // color: const Color(0xffFBFBFB),

      padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...data.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: const Color(0xffFBFBFB),
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e['type'],
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.sp)),
                      SizedBox(height: 4.h),
                      Text(e['explain'],
                          style: TextStyle(
                              fontSize: 14.sp, color: ColorCode.grey80))
                    ],
                  ),
                ),
                if (e['typeList'] != null)
                  ...e['typeList'].map((e) => Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffFBFBFB),
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: ColorCode.greyBorder))),
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(e, style: TextStyle(fontSize: 14.sp)),
                          ],
                        ),
                      )),
                SizedBox(height: 16.h)
              ],
            );
          }).toList(),
          SizedBox(height: 40.h),
          CustomButton.stretchTextBtnDisabledGreen(text: '이용권 구매기능은 준비중입니다')
        ],
      ),
    );
  }

  Widget price() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 14.h, top: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorCode.green0,
                    ),
                    child: Center(
                        child: Text('시간권',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 9.h, left: 8.w, right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('2시간'), Text('4,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('4시간'), Text('6,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('6시간'), Text('8,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('8시간'), Text('10,000원')],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.only(bottom: 14.h, top: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorCode.green0,
                    ),
                    child: Center(
                        child: Text('시간권',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 9.h, left: 8.w, right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('2시간'), Text('4,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('4시간'), Text('6,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('6시간'), Text('8,000원')],
                        ),
                      ],
                    ),
                  )
                ],
              )),
              SizedBox(width: 8.w),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 14.h, top: 14.h),
                    color: ColorCode.green0,
                    child: Center(
                        child: Text('시간권',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 9.h, left: 8.w, right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('2시간'), Text('4,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('4시간'), Text('6,000원')],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.only(bottom: 14.h, top: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorCode.green0,
                    ),
                    child: Center(
                        child: Text('시간권',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 9.h, left: 8.w, right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('2시간'), Text('4,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('4시간'), Text('6,000원')],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('6시간'), Text('8,000원')],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.only(bottom: 14.h, top: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorCode.green0,
                    ),
                    child: Center(
                        child: Text('시간권',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorCode.green50))),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 9.h, left: 8.w, right: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('2시간'), Text('4,000원')],
                        )
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 40.h),
          Text('환불규정',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp)),
          SizedBox(height: 5.h),
          Text('<환불은 결제 후 한달 이내에 가능합니다.>'),
          Text(
            '<※당일권, 사물함, 스터디룸 > 환불불가',
            style: TextStyle(height: 1.4.sp),
          ),
          SizedBox(height: 40.h)
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('지점소개',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h),
              const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
            ],
          ),
          SizedBox(height: 40.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이용안내',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h),
              const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
            ],
          ),
          SizedBox(height: 40.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('사물함 이용안내',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h),
              const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '),
            ],
          ),
          SizedBox(height: 40.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('상세 지점정보',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('전화번호'),
                        SizedBox(height: 8.h),
                        Text('주소'),
                        SizedBox(height: 8.h),
                        Text('대표자명'),
                        SizedBox(height: 8.h),
                        Text(
                          '사업자등록번호',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        Text('상호명'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('501-000-0000'),
                        SizedBox(height: 8.h),
                        Text('부산시 해운대구 산업로 1234-5 6층'),
                        SizedBox(height: 8.h),
                        Text('김패스'),
                        SizedBox(height: 8.h),
                        Text('000-00-00000'),
                        SizedBox(height: 8.h),
                        Text('컴패스 우동점'),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 28.h)
        ],
      ),
    );
  }
}
