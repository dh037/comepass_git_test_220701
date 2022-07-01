import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants/theme_data.dart';
import 'constants/routes_path.dart';

// TextEditingController : TEC
// TextFormField : TFF
// Button : btn
// Controller : Ctr

void main() {

  // 카카오 SDK init
  KakaoSdk.init(nativeAppKey: '30f7eb64a94c8067a5a75ed4033e43c8');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize : const Size(360,700), // Figma 시안 해상도
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.themeData,
            initialRoute: RoutePath.splashPage,
            // initialRoute: RoutePath.splashPage,
            routes: RoutePath.routes,
            // onGenerateRoute: RouteManager.generateRoute,
          );
        },
    );
  }
}
