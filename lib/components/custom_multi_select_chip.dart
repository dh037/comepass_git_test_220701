import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_code.dart';

class CustomMultiSelectChip extends StatefulWidget {
  final ValueChanged onSelected;
  final List list;
  final String? defaultChoice;
  final List? selectedChip = [];

  CustomMultiSelectChip({Key? key, required this.list, required this.onSelected, this.defaultChoice})
      : super(key: key);

  @override
  State<CustomMultiSelectChip> createState() => _CustomMultiSelectChipState();
}

class _CustomMultiSelectChipState extends State<CustomMultiSelectChip> {
  late String selectedChoice;
  List choice = [];

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
                  if (choice.length == 1000) {
                    if (choice.contains(e)) {
                      choice.remove(e);
                    }
                    // widget.onMax().call();
                    print('안되');

                  } else {
                    if (choice.contains(e)) {
                      choice.remove(e);
                    } else {
                      choice.add(e);
                    }
                  }
                  widget.onSelected(choice);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 6.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    border: Border.all(
                        color: choice.contains(e) ? ColorCode.green50 : ColorCode.greyBorder)),
                child: Text(e, style: choice.contains(e) ? selectedTextStyle() : disSelectedStyle()),
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
