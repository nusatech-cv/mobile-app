import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/auth_controller/auth_controller.dart';
import 'package:pijetin/utils/extension/extension.dart';

class ChooseRolePage extends StatelessWidget {
  ChooseRolePage({super.key});
  final AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Obx(() {
          return LoadingOverlay(
            isLoading: authController.isUpdateLoading.value,
            color: Colors.black,
            opacity: 0.5,
            progressIndicator: Center(
              child: CupertinoActivityIndicator(
                radius: 20.r,
                color: Colors.white,
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  AppImage.maskingOnboarding,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        24.0.height,
                        Text(
                          'Home Spa',
                          style: AppFont.bold32.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose your role account',
                        style: AppFont.medium16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      24.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          itemRole(
                            onTap: () {
                              authController.updateRole('Therapist');
                            },
                            image: AppImage.therapist,
                            roleName: 'Therapist',
                          ),
                          24.0.width,
                          itemRole(
                            onTap: () {
                              authController.updateRole('User');
                            },
                            image: AppImage.customer,
                            roleName: 'Customer',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget itemRole({
    required String image,
    required String roleName,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 37.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 70.w,
              height: 70.h,
            ),
            24.0.height,
            Text(
              roleName,
              style: AppFont.medium16,
            )
          ],
        ),
      ),
    );
  }
}
