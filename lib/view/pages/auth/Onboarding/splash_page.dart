import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../domain/controller/onboarding_controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            AppImage.maskingOnboarding,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SafeArea(
            child: Center(
              key: const Key('logo'),
                child: Image.asset(
              AppImage.logo,
              width: 125.w,
            )),
          ),
        ],
      ),
    );
  }
}
