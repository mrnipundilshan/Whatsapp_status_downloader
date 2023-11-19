import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status/getStatusProvider.dart';
import 'home.dart';
import 'getSavedprovider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetStatusProvider()),
        ChangeNotifierProvider(create: (context) => GetSavedProvider()),
      ],
      child: const MyWidget(),
    ),
  );
}

class GetStatesProvider {}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Status saver',
        home: const Stack(
          children: [SplashScreen()],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2)).then((value) => {
          Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (ctx) => const Home()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage("assets/splash.png"),
          width: 200,
        ),
        SizedBox(
          height: 50,
        ),
        SpinKitWaveSpinner(
          waveColor: Color.fromARGB(255, 3, 97, 51),
          color: Color.fromARGB(255, 61, 170, 117),
          size: 80.0,
        ),
      ]),
    );
  }
}
