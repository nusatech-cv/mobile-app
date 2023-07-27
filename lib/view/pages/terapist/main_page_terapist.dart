import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/controller.dart';
import 'package:pijetin/view/pages/terapist/HistoryTerapist/history_terapist.dart';
import 'package:pijetin/view/pages/terapist/HomePage/home_page_terapist.dart';
import 'package:pijetin/view/pages/terapist/ProfilePage/profile_page_therapist.dart';
import 'package:pijetin/view/pages/terapist/WalletPage/wallet_page_therapist.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';

class MainPageTerapist extends StatelessWidget {
  MainPageTerapist({super.key});
  final BottomNavBarTerapistController controller =
      Get.put(BottomNavBarTerapistController());
  @override
  Widget build(BuildContext context) {
    body() {
      switch (controller.bottomNavBarTerapistIndex.value) {
        case 0:
          return HomePageTerapist();
        case 1:
          return HistoryTerapist();
        case 2:
          return WalletPageTherapist();
        case 3:
          return ProfilePageTherapist();

        default:
          return HomePageTerapist();
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
                      AppIcon.walletIcon,
                      width: 24.h,
                      color: AppColor.textStrong,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.all(4.h),
                    child: Image.asset(
                      AppIcon.walletIcon,
                      width: 24.h,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  label: "Wallet"),
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
            currentIndex: controller.bottomNavBarTerapistIndex.value,
            onTap: (value) => controller.changeBottomNavBarTerapistIndex(value),
            backgroundColor: AppColor.cardColor,
            selectedItemColor: AppColor.primaryColor,
            selectedLabelStyle: AppFont.medium12,
            unselectedLabelStyle: AppFont.medium12,
            unselectedItemColor: AppColor.textStrong,
          ));
    });
  }
}
