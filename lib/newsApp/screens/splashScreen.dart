import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/news.png',
              fit: BoxFit.cover,
              width: width * 10,
              height: height * 0.5,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "TOP HEADLINES",
              style: GoogleFonts.anton(),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            const SpinKitWaveSpinner(
              color: Colors.black45,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
