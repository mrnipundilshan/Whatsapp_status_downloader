import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status/gettumnails.dart';
import 'save_image_view.dart';
import 'save_video_view.dart';
import 'getSavedprovider.dart';

class SaveHomePage extends StatefulWidget {
  const SaveHomePage({super.key});

  @override
  State<SaveHomePage> createState() => _SaveHomePageState();
}

class _SaveHomePageState extends State<SaveHomePage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/new2.png'),
        opacity: 0.3,
        fit: BoxFit.contain,
      )),
      child: Consumer<GetSavedProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getSavedStatus();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsappAvailable == false
            ? const Center(
                child: Text("Whatsapp Not Available"),
              )
            : file.getSaved.isEmpty
                ? const Center(
                    child: Text("No Image Available"),
                  )
                : Container(
                    padding: const EdgeInsets.all(20),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      children: List.generate(
                        file.getSaved.length,
                        (index) {
                          final data = file.getSaved[index];
                          if (data.path.endsWith(".mp4")) {
                            return FutureBuilder<String>(
                              future: getThumbnail(data.path),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) => VideoView1(
                                                videoPath: data.path,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 104, 89, 45),
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: FileImage(
                                                    File(snapshot.data!),
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.play_circle_filled,
                                              size: 50,
                                              color: Color.fromARGB(
                                                  164, 255, 255, 255),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Transform.scale(
                                        scale: 0.3,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 39, 145, 94),
                                          strokeWidth: 15,
                                        ),
                                      );
                              },
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => ImageView1(
                                              imagepath: data.path,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 104, 89, 45),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(data.path))),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
      }),
    ));
  }
}
