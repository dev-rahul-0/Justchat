import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:projecknew/pages/constants/helper_finctions.dart";
import "package:projecknew/pages/onboarding/dot_navigation..dart";
import "package:projecknew/pages/onboarding/getstarted.dart";
import "package:projecknew/pages/onboarding/onboarding_controler.dart";
import "package:projecknew/pages/onboarding/onboarding_nextButton.dart";
import "package:projecknew/pages/onboarding/onboarding_page.dart";
import "package:projecknew/pages/onboarding/onboarding_skip.dart";

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      backgroundColor:
          SHelperFunctions.isDarkMode(context) ? Colors.black87 : Colors.white,
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              onBoardingPage(
                image: "images/onboarding/Chat.gif",
                title: "Seamless Chatting Experience",
                subTitle:
                    "Chat with your friends about on going news headlines, current affairs.",
              ),
              onBoardingPage(
                image: "images/onboarding/Exciting news.gif",
                title: "Read Latest News",
                subTitle:
                    "Get updates to the latest news and chat with your friends about it and have a productive discussion",
              ),
              // onBoardingPage(
              //   image: "images/logo-removebg-preview.png",
              //   title: "",
              //   subTitle: "",
              // ),
              
            ],
          ),
          //Skip Button
          const OnBoardingSkip(),
          //Dot Navigation SmoothPageIndicator
          const onBoardingDotNavigation(),
          //Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
