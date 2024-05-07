import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:projecknew/firebase_options.dart';
import 'package:projecknew/pages/onboarding/onboarding_screen.dart';
import 'package:projecknew/pages/service/auth/auth_service.dart';
import 'package:projecknew/pages/service/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child:  MyApp(onboarding: onboarding,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({Key? key, required this.onboarding}) : super(key: key); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: onboarding? const AuthGate() : const OnBoardingScreen(),
    );
  }
}
