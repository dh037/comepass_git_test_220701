import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_code.dart';

class CustomSelectChip extends StatefulWidget {
  final ValueChanged onSelected;
  final List list;
  final String? defaultChoice;

  const CustomSelectChip({Key? key, required this.list, required this.onSelected, this.defaultChoice})
      : super(key: key);

  @override
  State<CustomSelectChip> createState() => _CustomSelectChipState();
}

class _CustomSelectChipState extends State<CustomSelectChip> {
  late String selectedChoice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedChoice  = widget.defaultChoice ?? "";
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...widget.list
            .map((e) => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChoice = e;
                          widget.onSelected(selectedChoice);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            border: Border.all(
                                color: selectedChoice == e ? ColorCode.green50 : ColorCode.greyBorder)),
                        child: Text(e, style: selectedChoice == e ? selectedTextStyle() : disSelectedStyle()),
                      ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ))
            .toList()
      ],
    );
  }

  TextStyle selectedTextStyle() {
    return TextStyle(
        fontSize: 12.sp, fontWeight: FontWeight.w700, color: ColorCode.green50);
  }

  TextStyle disSelectedStyle () {
    return TextStyle(fontSize: 12.sp);
  }

}
