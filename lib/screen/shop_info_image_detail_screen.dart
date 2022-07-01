import 'package:comepass/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/color_code.dart';
import '../constants/image_path.dart';

class ShopInfoImageDetailScreen extends StatefulWidget {
  const ShopInfoImageDetailScreen({Key? key}) : super(key: key);

  @override
  State<ShopInfoImageDetailScreen> createState() =>
      _ShopInfoImageDetailScreenState();
}

class _ShopInfoImageDetailScreenState
    extends State<ShopInfoImageDetailScreen> {
  late List shopImage;
  late int pageIndex;
  late PageController controller;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Object? args = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic> argsData = args as Map<String, dynamic>;
    shopImage = argsData['shopImage'];
    pageIndex = argsData['pageIndex'];
    controller = PageController(initialPage: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                    top: 20.h + MediaQuery.of(context).padding.top),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context,pageIndex);
                      },
                      child: SvgPicture.asset(
                        IconPath.iconDelete,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 52.h),
            ],
          ),
          Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState((){
                    pageIndex = value;
                  });
                },
                controller: controller,
                children: shopImage
                    .map((e) => Image.network(e))
                    .toList(),
              )),
          Column(
            children: [
              SizedBox(height: 66.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      shopImage.length,
                      (index) => Container(
                        width: 6.w,
                        height: 6.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: pageIndex == index
                                ? Colors.white
                                : const Color(0xffFFFFFF).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    )),
              ),
              SizedBox(height: 24.h)
            ],
          )
        ],
      ),
    );
  }
}
