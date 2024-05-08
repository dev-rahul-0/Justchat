import 'package:flutter/material.dart';
import 'package:projecknew/pages/constants/device_utilities.dart';
import 'package:projecknew/pages/constants/helper_finctions.dart';
import 'package:projecknew/pages/constants/sizes.dart';
import 'package:projecknew/pages/onboarding/onboarding_controler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = SHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: SDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: SSizes.defaultSpace,
      child: SmoothPageIndicator(
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? Colors.white : Colors.black87,
              dotHeight: 6),
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 2),
    );
  }
}
