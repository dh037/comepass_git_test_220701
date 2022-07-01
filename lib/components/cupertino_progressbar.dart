import 'package:comepass/constants/color_code.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/material.dart';

class CustomCupertinoProgressbar extends StatelessWidget {
  final double value;

  const CustomCupertinoProgressbar({Key? key, this.value = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoProgressBar(
      valueColor: ColorCode.black,
      trackColor: ColorCode.greyBorder,
      value: value,
    );
  }
}
