import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecknew/pages/service/auth_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: const Image(
              fit: BoxFit.cover,
              image: AssetImage("images/logo-removebg-preview.png")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.blue),
            width: MediaQuery.of(context).size.width * 9,
            height: 55,
            child: TextButton(
                onPressed: () async {
                  final pres = await SharedPreferences.getInstance();
                  pres.setBool("onboarding", true);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AuthGate()));
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        )
      ],
    );
  }
}
