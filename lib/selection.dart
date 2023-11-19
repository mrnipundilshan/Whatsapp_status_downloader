import 'package:flutter/material.dart';

class selection extends StatefulWidget {
  const selection({Key? key});

  @override
  State<selection> createState() => _SelectionState();
}

class _SelectionState extends State<selection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(185, 28, 95, 62),
              borderRadius:
                  BorderRadius.circular(20), // Adjust the corner radius here
            ),
            padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 18,
                right: 18), // Add padding to increase the background size
            child: const Text(
              "Whatsapp Status",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
