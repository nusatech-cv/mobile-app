import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/auth_controller/auth_controller.dart';
import 'package:pijetin/domain/controller/terapist_controller/profile_terapist_controller.dart';
import 'package:pijetin/view/pages/terapist/ProfilePage/components/account_activity_therapist_page.dart';
import 'package:pijetin/view/pages/terapist/ProfilePage/components/my_profile_therapist_page.dart';

import '../../../../domain/controller/websocket_controller.dart';
import '../../../../utils/utils.dart';

class ProfilePageTherapist extends StatelessWidget {
  ProfilePageTherapist({super.key});
  final ProfileTherapistController controller =
      Get.put(ProfileTherapistController());
  final AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerProfile(),
            accountProfile(),
            accountSetting(),
          ],
        ),
      )),
    );
  }

  Widget accountSetting() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Setting',
            style: AppFont.medium16.copyWith(
              color: AppColor.textSoft,
            ),
          ),
          16.0.height,
          itemProfile(
            onTap: () {},
            image: AppIcon.support,
            name: 'Statement and Support',
          ),
          const Divider(),
          itemProfile(
            onTap: () {},
            image: AppIcon.setting,
            name: 'Privacy Setting',
          ),
          const Divider(),
          16.0.height,
          itemProfile(
            onTap: () {
              authController.logoutWithGoogle();
              Websocket.instance.onClose();
            },
            image: AppIcon.logout,
            name: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget accountProfile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Profile',
            style: AppFont.medium16.copyWith(
              color: AppColor.textSoft,
            ),
          ),
          16.0.height,
          itemProfile(
            onTap: () {
              Get.to(() => MyProfileTherapistPage());
            },
            image: AppIcon.profileIcon,
            name: 'My Profile',
          ),
          const Divider(),
          itemProfile(
            onTap: () {
              Get.to(() => AccountActivityTherapistPage());
            },
            image: AppIcon.experienceIcon,
            name: 'Account Activity',
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget itemProfile({
    required String image,
    required String name,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 24.w,
              color: AppColor.primaryColor,
            ),
            16.0.width,
            Text(
              name,
              style: AppFont.medium14,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColor.textSoft,
            ),
          ],
        ),
      ),
    );
  }

  Widget headerProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              controller.user.value.therapist?.photo?.url ?? '',
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.user.value.firstName} ${controller.user.value.lastName}",
                  style: AppFont.medium16,
                ),
                Text(
                  controller.user.value.email ?? '',
                  style: AppFont.medium12.copyWith(
                    color: AppColor.textSoft,
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
