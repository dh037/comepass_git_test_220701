import 'package:comepass/components/custom_bottom_nav.dart';
import 'package:comepass/components/custom_floating_action_button.dart';
import 'package:comepass/notifier/main/bottom_nav_notifier.dart';
import 'package:comepass/screen/setting_screen.dart';
import 'package:comepass/screen/shop_list_screen.dart';
import 'package:comepass/screen/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BottomNavNotifier _bottomNavNotifier;

  final controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    _bottomNavNotifier = context.read<BottomNavNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomNav(
          bottomNavNotifier: _bottomNavNotifier,
        ),
        body: content(context));
  }

  content(BuildContext context) {
    return Consumer<BottomNavNotifier>(
        builder: (BuildContext context, value, Widget? child) => IndexedStack(
              index: _bottomNavNotifier.bottomNavCurrentIndex,
              children: [
                const HomeScreen(),
                const ShopListScreen(),
                const SizedBox.shrink(),
                const VoucherScreen(),
                Navigator(key: _bottomNavNotifier.setting, onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(builder: (context) => const SettingScreen());
                }),
              ],
            ));
  }
}
