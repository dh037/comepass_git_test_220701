import 'package:comepass/components/custom_appbar.dart';
import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../notifier/main/update_notifier.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  Map<String, dynamic> profileData = {
    "이름": "강아지",
    "생년월일": "2022.01.01",
    "이메일": "cutedog12@gmail.com",
    "휴대전화": "010 0000 0000",
    "보호자 연락처": "010 0000 0000",
  };

  late UpdateNotifier _updateNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateNotifier = context.read<UpdateNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
          title: "내정보",
          createLeadingIcon: true,
          onPressed: () => Navigator.pop(context)),
      body: content(),
    );
  }

  content() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 1, color: Color(0xff000000).withOpacity(0.1)),
                      image: DecorationImage(
                          image: AssetImage(ImagePath.shopImage))),
                ),
                Positioned(
                    bottom: 2.h,
                    right: 2.w,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorCode.greyBorder),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset(
                        IconPath.iconCamera,
                        color: ColorCode.grey60,
                      ),
                    ))
              ]),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("내프로필",
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 16.h),
                UpdateTextField(
                  type: '이름',
                  initialValue: profileData['이름'],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UpdateTextField extends StatefulWidget {
  final String type;
  final String initialValue;

  UpdateTextField({Key? key, this.initialValue = "", this.type = ""})
      : super(key: key);

  @override
  State<UpdateTextField> createState() => _UpdateTextFieldState();
}

class _UpdateTextFieldState extends State<UpdateTextField> {
  bool isDisabled = true;
  bool isValidateStart = false;
  bool validateState = true;

  String validateString = "";

  late TextEditingController _controller;
  late FocusNode _focusScope;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusScope = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusScope.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.type,
            style: TextStyle(
                color: ColorCode.grey70,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp)),
        Container(
          padding: EdgeInsets.only(bottom: 4.h, top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _focusScope,
                      onChanged: (value) {
                        setState(() {
                          isValidateStart = true;
                        });
                        if (value.isEmpty) {
                          setState(() {
                            validateState = false;
                            validateString = '데이터 입력 ㄱ';
                          });
                        } else {
                          setState(() {
                            validateState = true;
                            validateString = "";
                          });
                        }
                      },
                      controller: _controller,
                      enabled: !isDisabled,
                      cursorColor: validateState ? ColorCode.green50 : ColorCode.red50,
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        suffixIconConstraints:
                            BoxConstraints(minHeight: 12.w, minWidth: 12.w),
                        suffixIcon: isDisabled
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  _controller.text = "";
                                },
                                child: isValidateStart
                                    ? validateState
                                        ? SvgPicture.asset(
                                            IconPath.iconComplete)
                                        : SvgPicture.asset(IconPath.iconNotice)
                                    : SvgPicture.asset(IconPath.iconClose)),
                        isDense: true,
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w,
                                // color: ColorCode.green50
                                color: Colors.transparent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.w, color: validateState ? ColorCode.green50 : ColorCode.red50)),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w)
                ],
              )),
              isDisabled
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isDisabled = false;

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Text("수정",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12.sp)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: ColorCode.greyBorder)),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isValidateStart = false;
                          isDisabled = true;
                          validateString = "";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Text("적용하기",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp)),
                        decoration: BoxDecoration(
                            color: ColorCode.green50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.transparent)),
                      ),
                    )
            ],
          ),
        ),
        validateString == ""
            ? const SizedBox.shrink()
            : Text(
                validateString,
                style: TextStyle(color: Colors.red, fontSize: 10.sp),
              )

        // Text('이름',
        //     style: TextStyle(
        //         color: ColorCode.grey70,
        //         fontWeight: FontWeight.w700,
        //         fontSize: 12.sp)),
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 10.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //           child: Row(
        //         children: [
        //           Expanded(
        //             child: Container(
        //               child: TextFormField(
        //                 initialValue: '이름',
        //                 enabled: true,
        //                 cursorColor: ColorCode.green50,
        //                 cursorWidth: 2,
        //                 cursorHeight: 15,
        //                 decoration: InputDecoration(
        //                   suffixIconConstraints:
        //                       BoxConstraints(minHeight: 12.w, minWidth: 12.w),
        //                   suffixIcon: SvgPicture.asset(IconPath.iconClose),
        //                   isDense: true,
        //                   disabledBorder: UnderlineInputBorder(
        //                       borderSide: BorderSide(
        //                           width: 2.w,
        //                           // color: ColorCode.green50
        //                           color: Colors.transparent)),
        //                   focusedBorder: UnderlineInputBorder(
        //                       borderSide: BorderSide(
        //                           width: 2.w, color: ColorCode.green50)),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           SizedBox(width: 18.w)
        //         ],
        //       )),
        //       GestureDetector(
        //         onTap: () {},
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        //           child: Text("적용하기",
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.w700,
        //                   fontSize: 12.sp)),
        //           decoration: BoxDecoration(
        //               color: ColorCode.green50,
        //               borderRadius: BorderRadius.circular(4),
        //               border: Border.all(color: ColorCode.greyBorder)),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
