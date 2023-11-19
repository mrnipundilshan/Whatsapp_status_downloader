import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'getStatusProvider.dart';
import 'video_view.dart';
import 'gettumnails.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key});

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
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
        child: Consumer<GetStatusProvider>(
          builder: (context, file, child) {
            if (file.getVideos.isEmpty) {
              file.getStatus(".mp4");
            }
            return file.isWhatsappAvailable == false
                ? const Center(
                    child: Text("Whatsapp Not Available"),
                  )
                : file.getVideos.isEmpty
                    ? const Center(
                        child: Text("No Videos Available"),
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: file.getVideos.length,
                          itemBuilder: (context, index) {
                            final data = file.getVideos[index];

                            return FutureBuilder<String>(
                              future: getThumbnail(data.path),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) => VideoView(
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
                                                  155, 255, 255, 255),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Transform.scale(
                                        scale: 0.4,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 39, 145, 94),
                                          strokeWidth: 15,
                                        ),
                                      );
                              },
                            );
                          },
                        ),
                      );
          },
        ),
      ),
    );
  }
}
