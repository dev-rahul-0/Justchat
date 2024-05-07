import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projecknew/pages/constants/device_utilities.dart';
import 'package:projecknew/pages/constants/helper_finctions.dart';
import 'package:projecknew/pages/constants/sizes.dart';
import 'package:projecknew/pages/onboarding/onboarding_controler.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Positioned(
        right: SSizes.defaultSpace,
        bottom: SDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () {
            OnBoardingController.instance.nextPage();
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? Colors.white : Colors.black),
          child: const Icon(Iconsax.arrow_right_3),
        ));
  }
}
