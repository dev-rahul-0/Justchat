import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnableOnboarding extends StatelessWidget {
  const EnableOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: ()async{
           final prefs = await SharedPreferences.getInstance();
           prefs.setBool("onboarding", false);
          },
          child: const Text("Enable onboarding"),
        ),
      ),
    );
  }
}