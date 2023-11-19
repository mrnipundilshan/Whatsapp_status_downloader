import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:video_player/video_player.dart';

class VideoView1 extends StatefulWidget {
  final String? videoPath;
  const VideoView1({Key? key, this.videoPath}) : super(key: key);

  @override
  State<VideoView1> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView1> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController;

  ///list of buttons
  List<Widget> buttonsList = const [
    Icon(
      Icons.share,
      color: Colors.white,
      size: 32.0,
    ),
    Icon(
      Icons.close_fullscreen,
      color: Colors.white,
      size: 32.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(
      File(widget.videoPath!),
    )..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            autoInitialize: true,
            autoPlay: false,
            looping: true,
            showControlsOnInitialize: false,
            customControls: const Column(children: []),
            errorBuilder: (context, errorMessage) {
              return Center(child: Text(errorMessage));
            },
          );
          _videoPlayerController.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true; // Allow back navigation
      },
      child: Scaffold(
          body: Stack(children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_chewieController!
                      .videoPlayerController.value.isPlaying) {
                    _chewieController!.pause();
                  } else {
                    _chewieController!.play();
                  }
                });
              },
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator()),
            ),
            AnimatedOpacity(
              opacity:
                  _chewieController?.videoPlayerController.value.isPlaying ??
                          true
                      ? 0.0
                      : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.play_arrow,
                      size: 64, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _chewieController?.play();
                    });
                  },
                ),
              ),
            ),
          ]),
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
                        FlutterNativeApi.shareImage(widget.videoPath!);
                        break;
                      case 1:
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        // ignore: use_build_context_synchronously
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
