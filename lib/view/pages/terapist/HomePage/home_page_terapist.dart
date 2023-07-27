import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/terapist_controller/home_terapist_controller.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/view/pages/terapist/HomePage/components/post_booking_terapist.dart';
import 'package:pijetin/view/pages/terapist/HomePage/components/upcoming_booking_terapist.dart';
import 'package:pijetin/view/widget/app_bar_home.dart';
import 'package:pijetin/view/widget/rating.dart';
import '../../../../utils/utils.dart';

class HomePageTerapist extends StatelessWidget {
  HomePageTerapist({super.key});
  final HomeTerapistController controller = Get.put(HomeTerapistController());
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
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
                            userController.user.value.therapist?.photo?.url ??
                                ''),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          userController.getUser();
                          controller.getOrderUser();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            cardBalanceInformation(),
                            24.0.height,
                            tabBarListBookingTerapist(context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
      }),
    );
  }

  DefaultTabController tabBarListBookingTerapist(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: controller.tabBookingUserIndex.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 64.h,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColor.cardColor,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      color: Theme.of(context).hoverColor)
                ]),
            child: TabBar(
              // automaticIndicatorColorAdjustment: false,
              indicator: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8.r)),
              isScrollable: false,

              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              labelPadding: EdgeInsets.zero,
              labelStyle: AppFont.semibold16,
              unselectedLabelColor: AppColor.textSoft,
              unselectedLabelStyle: AppFont.medium16,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (index) {
                controller.changeTabBookingIndex(index);
              },
              tabs: const [
                Tab(
                  child: Text(
                    "Upcoming Booking",
                  ),
                ),
                Tab(
                  child: Text(
                    "Past Booking",
                  ),
                ),
              ],
            ),
          ),
          16.0.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              AppImage.bannerHomeUser,
              height: 182.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          24.0.height,
          controller.tabBookingUserIndex.value == 0
              ? UpcomingBookingTerapist()
              : PostBookingTerapist()
        ],
      ),
    );
  }

  Container cardBalanceInformation() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColor.cardColor),
      child: Row(
        children: [
          Image.asset(
            AppIcon.scanIcon,
            width: 24.w,
          ),
          16.0.width,
          SizedBox(
              width: 1.w,
              height: 20.h,
              child: VerticalDivider(
                thickness: 1.w,
                color: AppColor.primaryColor,
              )),
          16.0.width,
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 139.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo',
                      style:
                          AppFont.medium10.copyWith(color: AppColor.textSoft),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppIcon.wallet,
                          width: 24.w,
                        ),
                        8.0.width,
                        Text(
                          NumberFormat.currency(
                                  symbol: 'Rp ',
                                  decimalDigits: 2,
                                  locale: 'id_ID')
                              .format(userController.user.value.balance ?? 0),
                          style: AppFont.medium14
                              .copyWith(color: AppColor.textSoft),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 139.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating ${userController.user.value.averageRating ?? 0.0}',
                      style:
                          AppFont.medium10.copyWith(color: AppColor.textSoft),
                    ),
                    2.0.height,
                    Rating(
                      rate: userController.user.value.averageRating ?? 0,
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
