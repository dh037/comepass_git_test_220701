import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_code.dart';

class CustomMainTabBar extends StatefulWidget {
  ValueChanged? onChanged;
  CustomMainTabBar({Key? key, this.onChanged}) : super(key: key);

  @override
  State<CustomMainTabBar> createState() => _CustomMainTabBarState();
}

class _CustomMainTabBarState extends State<CustomMainTabBar> {
  List<String> category = ['이용권구매', '가격안내', '정보'];
  String choose = "이용권구매";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1, color: ColorCode.greyBorder),
      )),
      child: Row(
        children: category
            .map((e) => Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      choose = e;
                      widget.onChanged!(e);
                    });
                  },
                  child: Container(
                    color: choose == e ? Colors.white : ColorCode.grey30,
                    child: Center(child: Text(e.toString(),style: TextStyle(
                      color: choose == e ? Colors.black : ColorCode.grey60,
                      fontSize: 14.sp,
                      fontWeight: choose == e ? FontWeight.w700 : FontWeight.w400
                    ))),
                  ),
                )))
            .toList(),
      ),
    );
  }
}
