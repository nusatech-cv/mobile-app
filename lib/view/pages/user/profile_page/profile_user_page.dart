import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/theme.dart';
import 'package:pijetin/data/src/src.dart';
import 'package:pijetin/domain/controller/auth_controller/auth_controller.dart';
import 'package:pijetin/domain/controller/controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/profile_page/components/account_activity_user_page.dart';
import 'package:pijetin/view/pages/user/profile_page/components/my_profile_user_page.dart';

class ProfileUserPage extends StatelessWidget {
  ProfileUserPage({super.key});

  final UserController controller = Get.put(UserController());
  final AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = controller.user.value;
        return SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(user.avatar!)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  12.0.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.firstName} ${user.lastName}",
                          style: AppFont.reguler14
                              .copyWith(color: AppColor.textSoft),
                        ),
                        Text(
                          user.email ?? "",
                          style: AppFont.semibold16
                              .copyWith(color: AppColor.textStrong),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  Text(
                    "Account Profile",
                    style: AppFont.medium16.copyWith(color: AppColor.textSoft),
                  ),
                  16.0.height,
                  _settingItem(
                    onTap: () => Get.to(() => MyProfileUserPage()),
                    title: "My Profile",
                    icon: AppIcon.myProfile,
                  ),
                  const Divider(),
                  _settingItem(
                    onTap: () => Get.to(() => AccountActivityUserPage()),
                    title: "Account Activity",
                    icon: AppIcon.accountActivity,
                  ),
                  16.0.height,
                  Text(
                    "Account Setting",
                    style: AppFont.medium16.copyWith(color: AppColor.textSoft),
                  ),
                  16.0.height,
                  _settingItem(
                    title: "Statement and Support",
                    icon: AppIcon.support,
                  ),
                  const Divider(),
                  _settingItem(
                      title: "Privacy Setting", icon: AppIcon.privacySetting),
                  const Divider(),
                  32.0.height,
                  _settingItem(
                    onTap: () {
                      authController.logoutWithGoogle();
                    },
                    title: "Logout",
                    icon: AppIcon.logout,
                  ),
                ],
              ),
            )
          ],
        ));
      }),
    );
  }

  Widget _settingItem({String? title, String? icon, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Image.asset(
              icon ?? AppIcon.myProfile,
              height: 24.w,
              width: 24.w,
            ),
            16.0.width,
            Text(
              title ?? "",
              style: AppFont.medium14,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: AppColor.textSoft,
            )
          ],
        ),
      ),
    );
  }
}
