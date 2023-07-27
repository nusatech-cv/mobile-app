import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/user_controller/home_user_controller.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/utils/extension/extension.dart';
import 'package:pijetin/view/pages/user/nearby_therapist_page/nearby_therapist_page.dart';
import 'package:pijetin/view/pages/user/services_page/components/services_item.dart';
import 'package:pijetin/view/pages/user/services_page/services_page.dart';
import 'package:pijetin/view/pages/user/top_therapist_page.dart/top_therapist_page.dart';
import 'package:pijetin/view/pages/user/home_page/components/top_therapist.dart';
import 'package:pijetin/view/widget/app_bar_home.dart';

class HomePageUser extends StatelessWidget {
  HomePageUser({super.key});

  final HomeUserController controller = Get.put(HomeUserController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return userController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      AppBarHome(
                        name:
                            "${userController.user.value.firstName ?? ''} ${userController.user.value.lastName ?? ''}",
                        image:
                            userController.user.value.avatar ?? '',
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => controller.refreshPage(),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _location(),
                                _searchField(),
                                _banner(),
                                _services(),
                                TopTherapist(
                                  onTapSeeAll: () =>
                                      Get.to(() => const TopTherapistPage()),
                                ),
                                24.0.height,
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _location() {
    return Row(
      children: [
        Image.asset(
          AppIcon.locationIcon,
          height: 24.w,
          width: 24.w,
        ),
        8.0.width,
        Text(
          "My Location",
          style: AppFont.semibold16.copyWith(color: AppColor.textStrong),
        ),
        48.0.width,
        Expanded(
          child: Text(
            userController.myLocation.value,
            style: AppFont.medium12.copyWith(color: AppColor.textSoft),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }

  Widget _searchField() {
    return GestureDetector(
      onTap: () => Get.to(() => const NearbyTherapist()),
      child: Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Find nearby terapist",
              style: AppFont.reguler12.copyWith(color: AppColor.textSoft),
            ),
            Image.asset(
              AppIcon.moreIcon,
              height: 24.w,
              width: 24.w,
            ),
          ],
        ),
      ),
    );
  }

  Container _banner() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          image: const DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppImage.bannerHomeUser))),
    );
  }

  Widget _services() {
    return (controller.serviceList.isEmpty ||
            controller.isLoadingServices.value)
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services",
                      style: AppFont.medium16.copyWith(
                        color: AppColor.textStrong,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => ServicesPage()),
                      child: Text(
                        "See All",
                        style: AppFont.medium16.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                16.0.height,
                controller.isLoadingServices.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.serviceList.isEmpty
                        ? Text(
                            'No data found',
                            style: AppFont.reguler18,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.serviceList
                                .take(4)
                                .map((element) => Flexible(
                                      child: ServicesItem(
                                        name: element.name ?? "",
                                        icon: element.image!.url,
                                      ),
                                    ))
                                .toList(),
                          )
              ],
            ),
          );
  }
}
