import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';

class ImageView1 extends StatefulWidget {
  final String? imagepath;
  const ImageView1({Key? key, this.imagepath}) : super(key: key);

  @override
  State<ImageView1> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView1> {
  ///list of buttons
  List<Widget> buttonsList = [
    const Icon(
      Icons.share,
      color: Colors.white,
      size: 32.0,
    ),
    const Icon(
      Icons.close_fullscreen,
      color: Colors.white,
      size: 32.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 00), () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        });
        return true; // Allow back navigation
      },
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: FileImage(File(widget.imagepath!))),
              color: Colors.black,
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(buttonsList.length, (index) {
                return FloatingActionButton(
                  backgroundColor: const Color.fromARGB(125, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // BorderRadius for rounded corners
                    side: const BorderSide(
                        color: Color.fromARGB(106, 255, 255, 255),
                        width: 2.0), // Border color and width
                  ),
                  heroTag: "$index",
                  onPressed: () async {
                    switch (index) {
                      case 0:
                        log("Share");
                        FlutterNativeApi.shareImage(widget.imagepath!);
                        break;

                      case 1:
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.pop(
                            context); // Navigate back to the previous page
                        break;
                    }
                  },
                  child: buttonsList[index],
                );
              }),
            ),
          )),
    );
  }
}
