import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<String> reportList = ["APPLE", "PEACH", "GRAPE", "BANANA"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CustomChip(
              list: reportList,
              onSelected: (value) {
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatefulWidget {
  final ValueChanged<List>? onSelected;
  final List<String>? list;

  const CustomChip({Key? key, this.onSelected, this.list}) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false;
  List choice = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list!
          .map((e) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (choice.length == 3) {
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
                    widget.onSelected!(choice);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Center(child: Text(e)),
                    color: choice.contains(e)
                        ? Colors.green
                        : Colors.grey.withOpacity(0.4),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
