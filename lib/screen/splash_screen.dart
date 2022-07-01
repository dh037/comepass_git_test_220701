import 'dart:async';
import 'package:comepass/constants/color_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/routes_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // 스플래쉬 화면 진입 후 1.5초 후 login 페이지로 이동
    Timer(const Duration(milliseconds: 1500), () async {

      // String clientId = await RestApi().authorize();
      // print(clientId);
      // // 받은 클라이언트 아이디를 hive에 저장

      Navigator.popAndPushNamed(context, RoutePath.loginPage);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/image/comepass_splash.svg",width: 118.w,height: 72.h)
          ],
        ),
      ),
    );
  }
}

// 알 수 없음 페이지
// class ErrorPage extends StatelessWidget {
//   const ErrorPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text('ERROR PAGE')
//           ],
//         ),
//       )
//     );
//   }
// }
