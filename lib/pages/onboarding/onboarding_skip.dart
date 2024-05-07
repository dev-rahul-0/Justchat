
import 'package:flutter/material.dart';
import 'package:projecknew/pages/constants/device_utilities.dart';
import 'package:projecknew/pages/constants/sizes.dart';
import 'package:projecknew/pages/onboarding/onboarding_controler.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: SDeviceUtils.getAppBarHeight(),
        right: SSizes.defaultSpace,
        child: TextButton(
          onPressed: () {
            OnBoardingController.instance.skipPage();
          },
          child: const Text('Skip'),
        ));
  }
}
