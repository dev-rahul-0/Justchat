import "package:flutter/cupertino.dart";
import "package:get/get.dart";
import "package:projecknew/pages/login_page.dart";
import "package:projecknew/pages/onboarding/getstarted.dart";
import "package:projecknew/pages/service/auth/login_or_register.dart";
import "package:projecknew/pages/service/auth_gate.dart";

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //Update Current Index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  //jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 1) {
      Get.to(const GetStarted());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //update current index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 1;
    pageController.jumpToPage(1);
  }
}
