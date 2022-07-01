import 'package:comepass/constants/color_code.dart';
import 'package:comepass/constants/icon_path.dart';
import 'package:comepass/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MyPage(),
          );
        });
  }
}

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  PageController controller = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: content(context));
  }

  Widget content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100),
          Carousel(
            height: 150,
            items: ['aa','bb','cc'],
            builderFunction: (context, item) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Container(
                  width: 200,
                  color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 100),
          Container(
            height: 72.h,
            child: PageView(
              controller: controller,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4)),
                  width: 100,
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class Carousel extends StatelessWidget {
  Carousel({
    required this.items,
    required this.builderFunction,
    required this.height,
    this.dividerIndent = 10,
  });

  final List<dynamic> items;
  final double dividerIndent;

  final Function(BuildContext context, dynamic item) builderFunction;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.separated(
          physics: PageScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
            indent: dividerIndent,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            Widget item = builderFunction(context, items[index]);
            if (index == 0) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(left: dividerIndent),
              );
            } else if (index == items.length - 1) {
              return Padding(
                child: item,
                padding: EdgeInsets.only(right: dividerIndent),
              );
            }
            return item;
          }),
    );
  }
}
