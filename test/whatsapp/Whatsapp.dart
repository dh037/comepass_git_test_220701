import 'package:flutter/material.dart';

import 'chatTile.dart';
import 'storyButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Whatsapp(),
    );
  }
}

class Whatsapp extends StatefulWidget {
  @override
  _WhatsappState createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  //Adding the main color of the app
  Color mainColor = Color(0xFF177767);
  var containerRadius = Radius.circular(30.0);

  //Adding a list of image URL to simulate the avatar picture
  List<String> imageUrl = [
    "https://i.pinimg.com/originals/2e/2f/ac/2e2fac9d4a392456e511345021592dd2.jpg",
    "https://randomuser.me/api/portraits/men/86.jpg",
    "https://randomuser.me/api/portraits/women/80.jpg",
    "https://randomuser.me/api/portraits/men/43.jpg",
    "https://randomuser.me/api/portraits/women/49.jpg",
    "https://randomuser.me/api/portraits/women/45.jpg",
    "https://randomuser.me/api/portraits/women/0.jpg",
    "https://randomuser.me/api/portraits/women/1.jpg",
    "https://randomuser.me/api/portraits/men/0.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("WhatsApp Clone"),
        backgroundColor: mainColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          //First let's create the Story time line container
          Container(
            height: 100.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //Let's create a custom widget for our story button
                  storyButton(imageUrl[0], "Davie yo"),
                  storyButton(imageUrl[1], "Jack Brell"),
                  storyButton(imageUrl[2], "Anjie wo"),
                  storyButton(imageUrl[3], "Joseph "),
                  storyButton(imageUrl[4], "Juline kujo"),
                  storyButton(imageUrl[5], "Juline kujo"),
                  storyButton(imageUrl[6], "Juline kujo"),
                ],
              ),
            ),
          ),

          //Now let's create our chat timeline
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: containerRadius, topRight: containerRadius),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                child: ListView(
                  children: [
                    //Now let's create our chat tile custom widget
                    chatTile(imageUrl[0], "userName", "msg", "9Am", false),
                    chatTile(imageUrl[1], "userName", "msg", "8Am", true),
                    chatTile(imageUrl[2], "userName", "msg", "6Am", true),
                    chatTile(
                        imageUrl[3], "userName", "msg", "Yesterday", false),
                    chatTile(
                        imageUrl[5], "userName", "msg", "Yesterday", false),
                    chatTile(imageUrl[4], "userName", "msg", "San 20", true),
                    chatTile(imageUrl[6], "userName", "msg", "San20", true),
                    chatTile(imageUrl[7], "userName", "msg", "San20", true),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
