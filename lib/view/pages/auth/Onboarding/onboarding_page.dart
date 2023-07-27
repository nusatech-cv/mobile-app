import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/onboarding_controller/onboarding_controller.dart';
import 'package:pijetin/utils/extension/extension.dart';
import 'package:pijetin/view/pages/auth/GoogleSignIn/google_sign_in_page.dart';
import 'package:pijetin/view/widget/primary_button.dart';
import 'package:pijetin/view/widget/secondary_button.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            key: const Key('next'),
            AppImage.maskingOnboarding,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SafeArea(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      top: 24.h,
                    ),
                    child: Text(
                      'Home Spa',
                      style: AppFont.bold32.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  34.0.height,
                  Center(
                    child: Image.asset(
                      controller.currentPage.value == 0
                          ? AppImage.onboarding1
                          : controller.currentPage.value == 1
                              ? AppImage.onboarding2
                              : AppImage.onboarding3,
                      fit: BoxFit.cover,
                      width: 295.w,
                      height: 430.h,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 52.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.currentPage.value == 0
                                    ? 'Explore Massage\nServices'
                                    : controller.currentPage.value == 1
                                        ? 'Select Your Preferred\nTherapist'
                                        : 'Relax and Enjoy',
                                textAlign: TextAlign.center,
                                style: AppFont.semibold24,
                              ),
                              8.0.height,
                              Text(
                                controller.currentPage.value == 0
                                    ? 'Dive into a world of blissful massage services tailored to your preferences'
                                    : controller.currentPage.value == 1
                                        ? 'Our skilled and certified therapists are ready to provide you with an exceptional massage experience'
                                        : 'On the day of your massage, prepare your space to create a serene ambiance',
                                textAlign: TextAlign.center,
                                style: AppFont.reguler14.copyWith(
                                  color: AppColor.textSoft,
                                ),
                              ),
                              16.0.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  indicator(0),
                                  4.0.width,
                                  indicator(1),
                                  4.0.width,
                                  indicator(2),
                                ],
                              ),
                              16.0.height,
                              PrimaryButton(
                                title: 'Next',
                                onPressed: () {
                                  controller.changePage();
                                },
                              ),
                              16.0.height,
                              SecondaryButton(
                                key: const Key('skip'),
                                title: 'Skip',
                                onPressed: () {
                                  GetStorage().write('seenOnBoarding', true);
                                  Get.off(() => GoogleSignInPage());
                                },
                                borderColor: AppColor.background,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget indicator(int index) {
    return Container(
      width: controller.currentPage.value == index ? 24.w : 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: controller.currentPage.value == index
            ? AppColor.primaryColor
            : AppColor.strokeColor,
      ),
    );
  }
}
