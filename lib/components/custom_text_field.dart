import 'dart:ui';

import 'package:comepass/constants/color_code.dart';
import 'package:comepass/data/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/icon_path.dart';

class CustomTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  bool obscureText;

  String type;

  // styleHandling .... 직접 조절 해야하는 상황이 있음
  bool styleHandling;

  // 일단 넣어놓자
  Color borderColor;
  Color focusedBorderColorCursorColor;
  Widget? suffixIcon;
  Widget? prefixIcon;

  int? maxLength;
  Key? keyValue;
  FocusNode? focusNode;
  String? errorText;
  bool? enabled;

  List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChanged;
  ValueChanged<bool>? returnState;

  CustomTextField(
      {Key? key,
      this.type = 'id',
      required this.styleHandling,
      this.hintText,
      this.controller,
      this.obscureText = false,

      // 일단 넣어놓자
      this.borderColor = ColorCode.greyBorder,
      this.focusedBorderColorCursorColor = ColorCode.green50,
      this.suffixIcon,
      this.prefixIcon,
      this.errorText,

      //
      this.maxLength,
      this.keyValue,
      this.focusNode,
      this.inputFormatters,
      this.enabled,
      // onChanged도 일단 넣어놓자
      this.onChanged,
      //
      this.returnState})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color borderColor = ColorCode.greyBorder;
  Color focusedBorderColor = ColorCode.green50;
  Color cursorColor = ColorCode.green50;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? errorText;

  Function(String)? chooseValidator() {
    if (widget.type == "id") {
      return idValidation;
    } else if (widget.type == "name") {
      return nameValidation;
    } else if (widget.type == "birth") {
      return birthValidation;
    } else if (widget.type == "phone") {
      return phoneValidation;
    } else if (widget.type == "phone2") {
      return phone2Validation;
    } else if (widget.type == "kiosk") {
      return kioskValidation;
    } else if (widget.type == "email") {
      return emailValidation;
    }
  }

  idNormalStyle() {
    borderColor = ColorCode.greyBorder;
    focusedBorderColor = ColorCode.green50;
    cursorColor = ColorCode.green50;
    suffixIcon = Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: SvgPicture.asset(IconPath.iconComplete)));
    if (widget.returnState != null) widget.returnState!(true);
  }

  idErrorStyle() {
    borderColor = ColorCode.red50;
    focusedBorderColor = ColorCode.red50;
    cursorColor = ColorCode.red50;
    suffixIcon = Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: SvgPicture.asset(IconPath.iconNotice)));

    if (widget.returnState != null) widget.returnState!(false);
  }

  void idValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "아이디를 입력해주세요";
      idErrorStyle();
    } else if (value.contains(" ")) {
      errorText = "아이디에 공백을 포함할 수 없습니다.";
      idErrorStyle();
    } else if (!Regex.idRule().hasMatch(value)) {
      errorText = "아이디는 영문+숫자조합 5자 이상 12자 이하입니다.";
      idErrorStyle();
    }

    setState(() {});
  }

  void nameValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "이름을 입력해주세요";
      idErrorStyle();
    } else if (value.contains(" ")) {
      errorText = "이름에 공백을 포함할 수 없습니다.";
      idErrorStyle();
    } else if (!Regex.nameRule().hasMatch(value)) {
      errorText = "이름은 영문 + 한글만 허용됩니다.";
      idErrorStyle();
    }
    setState(() {});
  }
  void birthValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "생년월일을 입력해주세요";
      idErrorStyle();
    } else if (!Regex.birthRule().hasMatch(value)) {
      errorText = "생년월일 8자리를 다시 입력해주세요";
      idErrorStyle();
    }
    setState(() {});
  }
  void phoneValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "핸드폰번호를 입력해주세요";
      idErrorStyle();
    } else if (!Regex.phone2Rule().hasMatch(value)) {
      errorText = "올바른 전화번호를 입력해주세요";
      idErrorStyle();
    }
    setState(() {});
  }
  void phone2Validation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "핸드폰번호를 입력해주세요";
      idErrorStyle();
    } else if (!Regex.phone2Rule().hasMatch(value)) {
      errorText = "올바른 전화번호를 입력해주세요";
      idErrorStyle();
    }
    setState(() {});
  }
  void kioskValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "키오스크 출입코드를 입력해주세요";
      idErrorStyle();
    } else if (!Regex.kioskRule().hasMatch(value)) {
      errorText = "올바른 출입코드 4자리를 입력해주세요";
      idErrorStyle();
    }
    setState(() {});
  }

  void emailValidation(String? value) {
    errorText = null;
    idNormalStyle();

    if (value == "" || value!.isEmpty) {
      errorText = "이메일을 입력해주세요";
      idErrorStyle();
    } else if (value.contains(" ")) {
      errorText = "이메일은 공백을 포함할 수 없습니다";
      idErrorStyle();
    } else if (!Regex.emailRule().hasMatch(value)) {
      errorText = "올바른 이메일을 입력해주세요";
      idErrorStyle();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          enabled: widget.enabled,
          style: TextStyle(height: 1.4.sp, fontSize: 14.sp),
          obscureText: widget.obscureText,
          obscuringCharacter: '●',
          controller: widget.controller,
          cursorColor: widget.styleHandling ? widget.focusedBorderColorCursorColor : cursorColor,
          // handling이 true면 받아온색 아니면 지역변수의 색
          cursorWidth: 1.h,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          key: widget.keyValue,
          focusNode: widget.focusNode,
          textAlignVertical: TextAlignVertical.center,
          onChanged: widget.styleHandling ? widget.onChanged : chooseValidator(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: '',
            isDense: true,
            hintStyle: TextStyle(
                fontSize: 14.sp, color: ColorCode.grey60),
            contentPadding: EdgeInsets.only(bottom: 8.sp),
            suffixIconConstraints: BoxConstraints(
                minHeight: 0, minWidth: 0, maxWidth: 70.sp, maxHeight: 39.sp),
            suffixIcon: widget.styleHandling ? Padding(
              padding: EdgeInsets.only(bottom: 9.sp),
              child: widget.suffixIcon,
            ) : suffixIcon,
            // handling이 true면 받아온색 아니면 지역변수의 색 widget. 아닌거
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(bottom: 8.sp),
                    child: widget.prefixIcon)
                : prefixIcon,
            // handling이 true면 받아온색 아니면 지역변수의 색 widget. 아닌거
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.w,
                    color: widget.styleHandling
                        ? widget.borderColor
                        : borderColor) // handling이 true면 받아온색 아니면 지역변수의 색 widget. 아닌거
                ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.w,
                    color: widget.styleHandling
                        ? widget.focusedBorderColorCursorColor
                        : focusedBorderColor) // handling이 true면 받아온색 아니면 지역변수의 색 widget. 아닌거
                ),
          ),
        ),
        errorMsg()
      ],
    );
  }

  Widget errorMsg() {
    if (widget.styleHandling) {
      if (widget.errorText != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 4.h),
            Text(widget.errorText!,
                style: TextStyle(
                    fontSize: 10.sp, color: ColorCode.red50, height: 1.4.sp)),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (errorText != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 4.h),
            Text(errorText!,
                style: TextStyle(
                    fontSize: 10.sp, color: ColorCode.red50, height: 1.4.sp)),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}

/*

일반 TextField는 validation이랑 returnState만 있으면 되서 아주 간편함 하지만 validation은
이 파일에서 생성해야하는게 좀 그럼

styleHandler를 넣은 이유
우선 로그인 부터

로그인은 버튼을 눌렀을때만 변경을 시켜줘야한다. 그래서 CustomTextField 인스턴스를 생성하고 접근해서
color를 변경해줘야하고 ..... ( 인스턴스 접근해서 색을 변경 시킬려고 해도.. 하는 방법을 모르겠음) 변경
할 수는 있지만 반응형으로 안됨









*/
