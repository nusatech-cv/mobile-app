import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/terapist_controller/history_terapist_controller.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/terapist/HistoryTerapist/components/all_history_terapist.dart';
import 'package:pijetin/view/pages/terapist/HistoryTerapist/components/canceled_history_terapist.dart';
import 'package:pijetin/view/pages/terapist/HistoryTerapist/components/completed_history_terapist.dart';
import 'package:pijetin/view/widget/app_bar_home.dart';

import '../../../../config/config.dart';

class HistoryTerapist extends StatelessWidget {
  HistoryTerapist({super.key});
  final UserController userController = Get.find();
  final HistoryOrderTerapistController controller =
      Get.put(HistoryOrderTerapistController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              AppBarHome(
                  name:
                      "${userController.user.value.firstName ?? ''} ${userController.user.value.lastName ?? ''}",
                  image: userController.user.value.therapist?.photo?.url ?? ''),
              Expanded(
                  child: DefaultTabController(
                length: 3,
                initialIndex: controller.tabHistoryOrder.value,
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
                          controller.changeTabHistoryOrder(index);
                        },
                        tabs: const [
                          Tab(
                            child: Text(
                              "All",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Completed",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Canceled",
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.0.height,
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () => controller.getOrderUser(),
                      child: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.tabHistoryOrder.value == 0
                              ? AllHistoryTerapist()
                              : controller.tabHistoryOrder.value == 1
                                  ? CompletedHistoryTerapist()
                                  : CanceledHistoryTerapist(),
                    ))
                  ],
                ),
              ))
            ],
          ),
        )),
      );
    });
  }
}
