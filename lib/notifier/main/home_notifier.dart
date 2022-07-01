import 'package:comepass/data/model/voucher.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {

  // late Future value;
  // late Future<dynamic> value;
  Iterable<Future<dynamic>> value = [];
  // late List value;
  int voucherBannerDotIndicatorIndex = 0;
  int eventBannerIndex = 0;

  PageController pageController = PageController(viewportFraction: 0.8);

  List<Voucher> voucherList = [];

  voucherBanner(value) {
    voucherBannerDotIndicatorIndex = value;
    notifyListeners();
  }

  eventBanner(value) {
    eventBannerIndex = value;
    notifyListeners();
  }

  getData() async {
    await Future.delayed(const Duration(seconds: 1));

    Map<String, dynamic> voucherJsonData1 = {"shop_name": "캠퍼스 수영민락점"};
    Map<String, dynamic> voucherJsonData2 = {"shop_name": "캠퍼스 해운대점"};
    Map<String, dynamic> voucherJsonData3 = {"shop_name": "캠퍼스 기장점"};

    voucherList = [
      Voucher.fromJson(voucherJsonData1),
      Voucher.fromJson(voucherJsonData2),
      Voucher.fromJson(voucherJsonData3)
    ];


    return voucherList;
  }

  Future getUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    Map<String, dynamic> userData ={
      // "address": "분당구 판교동가나다라마",
    "address": null,
    // "name": "이탈리안 하이그라운드",
    "name": "강아지",
    "qr": 'asdfqwer1234',
    "noti" : true
    // "noti" : null
    };
    return userData;
  }

  Future getVoucherData() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Map<String, dynamic>> voucherData = [
      {
        "shop": "캠퍼스 수영민락점",
        "type": ['자유석', '정기시간권'],
        "time": ['5일·8시간', '2주·10시간']
      },
      {
        "shop": "캠퍼스 해운대점",
        "type": ['자유석', '정기시간권'],
        "time": ['2일·1시간', '7주·2시간']
      },
      {
        "shop": "캠퍼스 기장점",
        "type": ['자유석', '정기시간권'],
        "time": ['9일·1시간', '1주·2시간']
      },
      {
        "shop": "캠퍼스 기장점",
        "type": ['자유석', '정기시간권'],
        "time": ['9일·1시간', '1주·2시간']
      }
    ];
    return voucherData;
  }

  Future getEventBannerData() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Map<String, dynamic>> eventBannerData = [
      {
        'image':
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9iixTnS38TKiES2NcUdU_BRBp-uDQC6JKaA&usqp=CAU",
      },
      {
        'image':
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfBt4ofOeT2y7gR36k_Av0145P1i0Ql1vq8t2NpUxOYKwUucfyeYB0SHLww8sQjuYmaf8&usqp=CAU",
      },
      {
        'image':
        "https://cdn.pixabay.com/photo/2015/12/06/09/15/maple-1079235__480.jpg",
      },
      {
        'image':
        "https://img.freepik.com/free-vector/black-banner-with-yellow-geometric-shapes_1017-32327.jpg?w=2000",
      },
      {
        'image':
        "https://images.freeimages.com/images/small-previews/eb9/winter-road-1410833.jpg",
      }
    ];
    return eventBannerData;
  }

  Future getShopListData() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Map<String, dynamic>> shopListData = [
      {
        "shopImage":
        "https://cf.creatrip.com/original/blog/8373/cfbdh6046k02diqlrl2p5qbsw1punyys.png",
        "distance": "200m",
        "name": "컴패스 해운대동부센터점",
        "sheetCount": "24"
      },
      {
        "shopImage":
        "https://post-phinf.pstatic.net/MjAyMTA0MTVfMzkg/MDAxNjE4NDYyODQyMjg4.vPoSHnjS8ACm3kCUBdh_MswT9jCnUU7qqV5FO79v1AQg.oKsMAH-gxbrmHjla4gWqTP6jPvezZ2yzwXaJIHnUCeAg.JPEG/20180502104306-532eca29ec.jpg?type=w1200",
        "distance": "1km",
        "name": "컴패스 해운대점",
        "sheetCount": "58"
      },
      {
        "shopImage":
        "https://i.pinimg.com/736x/90/cd/f2/90cdf263b9a0787d6001fa5d5025af5c.jpg",
        "distance": "1.5km",
        "name": "컴패스 수영",
        "sheetCount": "67"
      }
    ];
    return shopListData;
  }
}





