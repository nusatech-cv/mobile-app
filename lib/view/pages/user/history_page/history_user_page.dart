import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/user_controller/order_user_controller.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/utils/extension/extension.dart';
import 'package:pijetin/view/pages/user/booking/booking_detail_page.dart';
import 'package:pijetin/view/widget/app_bar_home.dart';
import 'package:pijetin/view/widget/empty.dart';
import 'package:pijetin/view/widget/widget.dart';

class HistoryUserPage extends StatelessWidget {
  HistoryUserPage({super.key});

  final OrderUserController controller = Get.put(OrderUserController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                AppBarHome(
                  name:
                      "${userController.user.value.firstName} ${userController.user.value.lastName}",
                  image: userController.user.value.avatar,
                ),
                DefaultTabController(
                  length: 2,
                  initialIndex: controller.selectedTabIndex.value,
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
                            controller.changeTabIndex(index);
                          },
                          tabs: const [
                            Tab(
                              child: Text(
                                "History Appointment",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "On Going",
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.0.height,
                    ],
                  ),
                ),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () async => controller.getOrderUser(),
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.selectedTabIndex.value == 0
                          ? listhistoryDone()
                          : listhistoryOnGoing(),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget listhistoryDone() {
    return controller.orderList
            .where((element) =>
                element.orderStatus == "done" ||
                element.orderStatus == "cancel" ||
                element.orderStatus == "expired")
            .isEmpty
        ? const Center(
            child: Empty(title: "No data found"),
          )
        : ListView.builder(
            itemCount: controller.orderList
                .where((element) =>
                    element.orderStatus == "done" ||
                    element.orderStatus == "cancel" ||
                    element.orderStatus == "expired")
                .length,
            itemBuilder: (context, index) {
              final item = controller.orderList
                  .where((element) =>
                      element.orderStatus == "done" ||
                      element.orderStatus == "cancel" ||
                      element.orderStatus == "expired")
                  .toList()[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: CardBooking(
                  onTap: () {
                    Get.to(() => DetailBookingPage(
                          id: item.id!,
                        ));
                  },
                  order: item,
                ),
              );
            },
          );
  }

  listhistoryOnGoing() {
    return controller.orderList
            .where((element) =>
                element.orderStatus != "done" &&
                element.orderStatus != "cancel" &&
                element.orderStatus != "expired")
            .isEmpty
        ? const Center(
            child: Empty(title: "No data found"),
          )
        : ListView.builder(
            itemCount: controller.orderList
                .where((element) =>
                    element.orderStatus != "done" &&
                    element.orderStatus != "cancel" &&
                    element.orderStatus != "expired")
                .length,
            itemBuilder: (context, index) {
              final item = controller.orderList
                  .where((element) =>
                      element.orderStatus != "done" &&
                      element.orderStatus != "cancel" &&
                      element.orderStatus != "expired")
                  .toList()[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: CardBooking(
                  onTap: () {
                    Get.to(() => DetailBookingPage(
                          id: item.id!,
                        ));
                  },
                  order: item,
                ),
              );
            },
          );
  }
}
