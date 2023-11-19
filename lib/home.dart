import 'package:flutter/material.dart';
import 'package:status/image.dart';
import 'package:status/save.dart';
import 'package:status/video.dart';
import 'selection.dart';
import 'textbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          )),
          toolbarHeight: 85.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerRight,
                  image: AssetImage('assets/new2.png'),
                  opacity: 0.4,
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 3, 97, 51),
                  Color.fromARGB(255, 1, 153, 79)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            child: const selection(),
          ),
          bottom: textbar(),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: VideoHomePage(),
            ),
            Center(
              child: ImageHomePage(),
            ),
            Center(
              child: SaveHomePage(),
            ),
          ],
        ),
      ),
    );
  }
}
