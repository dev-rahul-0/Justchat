import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projecknew/pages/onboarding/enable_onbording.dart';
import 'package:projecknew/pages/service/auth/auth_service.dart';
import 'package:provider/provider.dart';
import '../extra features/chatscreenhealper.dart';
import '../newsApp/screens/categoryscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(NavigationController());

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'JustChat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: signOut,
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.black87,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnableOnboarding()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black87,
                )),
          ],
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            backgroundColor: Colors.grey.shade100,
            height: 60,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              const NavigationDestination(
                  icon: Icon(Iconsax.message), label: 'Chat'),
              NavigationDestination(
                  icon: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoryScreen()));
                      },
                      child: const Icon(Iconsax.book)),
                  label: 'News'),
            ],
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [Container(child: const ChatScreenHealper()), Container()];
}
