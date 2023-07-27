import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/auth_controller/auth_controller.dart';
import 'package:pijetin/utils/extension/double_extension.dart';
import 'package:pijetin/view/widget/widget.dart';


class GoogleSignInPage extends StatelessWidget {
  GoogleSignInPage({super.key});
  final AuthController authController = Get.put(AuthController());

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
            child: Column(
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
                    AppImage.getStarted,
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
                              'Welcome To Home Spa',
                              textAlign: TextAlign.center,
                              style: AppFont.semibold24,
                            ),
                            8.0.height,
                            Text(
                              'Providing you with an exceptional massage experience through our intuitive app',
                              textAlign: TextAlign.center,
                              style: AppFont.reguler14.copyWith(
                                color: AppColor.textSoft,
                              ),
                            ),
                            16.0.height,
                            Obx(() {
                              return SecondaryButton(
                                key: const Key('signInGoogle'),
                                icon: Image.asset(
                                  AppIcon.googleIcon,
                                  width: 24.w,
                                ),
                                isloading: authController.isLoading.value,
                                backgroundColor: AppColor.cardColor,
                                borderColor: AppColor.background,
                                title: 'Sign In with Google',
                                textColor: AppColor.textSoft,
                                onPressed: () {
                                  authController.signInWithGoogle();
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
