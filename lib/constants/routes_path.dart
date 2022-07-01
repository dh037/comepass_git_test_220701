import 'package:comepass/notifier/forgot/find_pwd_add_info_notifier.dart';
import 'package:comepass/notifier/forgot/forgot_id_notifier.dart';
import 'package:comepass/notifier/forgot/forgot_notifier.dart';
import 'package:comepass/notifier/login_notifier.dart';
import 'package:comepass/notifier/register/register_certification_notifier.dart';
import 'package:comepass/notifier/register/register_consent_notifier.dart';
import 'package:comepass/notifier/register/register_id_pwd_notifier.dart';
import 'package:comepass/notifier/register/register_info_notifier.dart';
import 'package:comepass/notifier/register/register_kiosk_notifier.dart';
import 'package:comepass/notifier/register/sso_register_notifier.dart';
import 'package:comepass/screen/register/register_success_screen.dart';
import 'package:comepass/screen/forgot/find_id_success_screen.dart';
import 'package:comepass/screen/forgot/find_pwd_success_screen.dart';
import 'package:comepass/screen/register/register_certification_screen.dart';
import 'package:comepass/screen/register/register_consent_screen.dart';
import 'package:comepass/screen/register/register_id_pwd_screen.dart';
import 'package:comepass/screen/register/register_info_screen.dart';
import 'package:comepass/screen/register/register_kiosk_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifier/main/bottom_nav_notifier.dart';
import '../notifier/main/home_notifier.dart';
import '../notifier/main/shop_info_notifier.dart';
import '../screen/forgot/find_pwd_add_info_screen.dart';
import '../screen/forgot/forgot_screen.dart';
import '../screen/login_screen.dart';
import '../screen/main_screen.dart';
import '../screen/shop_info_image_detail_screen.dart';
import '../screen/shop_info_screen.dart';
import '../screen/qr_screen.dart';
import '../screen/register/sso_register_screen.dart';
import '../screen/splash_screen.dart';

class RoutePath {
  static const String splashPage = "/splashPage";
  static const String loginPage = "/loginPage";

  static const String registerConsentPage = '/registerConsentPage';
  static const String registerCertificationPage = '/registerCertificationPage';
  static const String registerIdPwdPage = "/registerIdPwdPage";
  static const String registerInfoPage = "/registerInfoPage";
  static const String registerKioskPage = "/registerKioskPage";
  static const String registerSuccessPage = "/registerSuccessPage";

  static const String ssoRegisterPage = "/ssoRegisterPage";

  static const String forgotPage = "/forgotPage";

  static const String mainPage = "/mainPage";
  static const String findPwdAddInfo = "/findPwdAddInfo";
  static const String findIdSuccess = "/findIdSuccess";
  static const String findPwdSuccess = "/findPwdSuccess";

  static const String qrScreen = "/qrScreen";
  static const String shopInfoScreen = "/shopInfoScreen";
  static const String shopInfoImageDetailScreen = "/shopInfoImageDetailScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (context) => const SplashScreen(),
    loginPage: (context) => ChangeNotifierProvider(
        create: (_) => LoginNotifier(), child: LoginScreen()),
    registerConsentPage: (context) => ChangeNotifierProvider(
        create: (_) => RegisterConsentNotifier(),
        child: const RegisterConsentScreen()),
    registerCertificationPage: (context) => ChangeNotifierProvider(
          create: (_) => RegisterCertificationNotifier(),
          child: const RegisterCertificationScreen(),
        ),
    registerIdPwdPage: (context) => ChangeNotifierProvider(
        create: (_) => RegisterIdPwdNotifier(), child: RegisterIdPwdScreen()),
    registerInfoPage: (context) => ChangeNotifierProvider(
          create: (_) => RegisterInfoNotifier(),
          child: RegisterInfoScreen(),
        ),
    registerKioskPage: (context) => ChangeNotifierProvider(
          create: (_) => RegisterKioskNotifier(),
          child: RegisterKioskScreen(),
        ),
    registerSuccessPage: (context) => RegisterSuccessScreen(),
    ssoRegisterPage: (context) => ChangeNotifierProvider(
        create: (_) => SsoRegisterNotifier(), child: const SsoRegisterScreen()),
    forgotPage: (context) => MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => ForgotNotifier()),
          ChangeNotifierProvider(create: (_) => ForgotIdNotifier())
        ], child: const ForgotScreen()),
    findPwdAddInfo: (context) => ChangeNotifierProvider(
        create: (_) => FindPwdAddInfoNotifier(),
        child: const FindPwdAddInfoScreen()),
    mainPage: (context) => MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => BottomNavNotifier()),
          ChangeNotifierProvider(create: (_) => HomeNotifier())
        ], child: MainScreen()),
    findIdSuccess: (context) => const FindIdSuccessScreen(),
    findPwdSuccess: (context) => const FindPwdSuccessScreen(),
    qrScreen: (context) => const QrScreen(),
    shopInfoScreen: (context) => ChangeNotifierProvider(
        create: (_) => ShopInfoNotifier(), child: const ShopInfoScreen()),
    shopInfoImageDetailScreen: (context) => const ShopInfoImageDetailScreen(),
  };

// https://stackoverflow.com/questions/59822279/difference-between-ongenerateroute-and-routes-in-flutter
// 버그가 해결될떄 까지 routes 를 쓰는게 좋다???

// static Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case loginPage:
//       return MaterialPageRoute(builder: (context) => const LoginPage());
//     case splashPage :
//       return MaterialPageRoute(builder: (context) => const SplashPage());
//     case forgotPage :
//
//       return MaterialPageRoute(builder: (context) => ForgotPage());
//     default:
//       throw const FormatException('Route not found! check!');
//   }
// }
}
