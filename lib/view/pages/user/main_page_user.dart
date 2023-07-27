import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/user_controller/bottom_na_ba_user_controller.dart';
import 'package:pijetin/view/pages/user/history_page/history_user_page.dart';
import 'package:pijetin/view/pages/user/home_page/home_page_user.dart';
import 'package:pijetin/view/pages/user/profile_page/profile_user_page.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';

class MainPageUser extends StatelessWidget {
  MainPageUser({super.key});
  final BottomNavBarUserController controller =
      Get.put(BottomNavBarUserController());
  @override
  Widget build(BuildContext context) {
    body() {
      switch (controller.bottomNavBarUserIndex.value) {
        case 0:
          return HomePageUser();
        case 1:
          return HistoryUserPage();
        case 2:
          return ProfileUserPage();
        default:
          return HomePageUser();
      }
    }

    return Obx(() {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: body(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.homeIcon,
                      width: 24.h,
                      color: AppColor.textStrong,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.homeIcon,
                      width: 24.h,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.historyIcon,
                      width: 24.h,
                      color: AppColor.textStrong,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.historyIcon,
                      width: 24.h,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  label: "History"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.profileIcon,
                      width: 24.h,
                      color: AppColor.textStrong,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.profileIcon,
                      width: 24.h,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  label: "Profile"),
            ],
            elevation: 3,
            currentIndex: controller.bottomNavBarUserIndex.value,
            onTap: (value) => controller.changeBottomNavBarUserIndex(value),
            backgroundColor: AppColor.cardColor,
            selectedItemColor: AppColor.primaryColor,
            selectedLabelStyle: AppFont.medium12,
            unselectedLabelStyle: AppFont.medium12,
            unselectedItemColor: AppColor.textStrong,
          ));
    });
  }
}
