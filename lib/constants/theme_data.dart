import 'package:flutter/material.dart';
import 'color_code.dart';


class Themes {
  static ThemeData themeData = ThemeData(
      scaffoldBackgroundColor: ColorCode.white,
      fontFamily: 'Pretendard',
      appBarTheme: const AppBarTheme(
        color: ColorCode.white,
          titleTextStyle: TextStyle(
              fontFamily: 'Pretendard',
              color: ColorCode.black,
              fontWeight: FontWeight.w700,
              fontSize: 16)));
}
