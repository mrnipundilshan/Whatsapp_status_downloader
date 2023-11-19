import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'getStatusProvider.dart';
import 'image_view.dart';

class ImageHomePage extends StatefulWidget {
  const ImageHomePage({Key? key}) : super(key: key);

  @override
  State<ImageHomePage> createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
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
            if (file.getImages.isEmpty) {
              file.getStatus(".jpg");
            }

            return file.getImages.isEmpty
                ? const Center(
                    child: Text("No Image Available"),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: file.getImages.length,
                    itemBuilder: (context, index) {
                      final data = file.getImages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageView(
                                imagepath: data.path,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 104, 89, 45),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(data.path)),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
