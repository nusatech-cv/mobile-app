import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/activity_controller/activity_controller.dart';
import 'package:pijetin/utils/extension/double_extension.dart';
import 'package:pijetin/view/widget/activity_item.dart';
import 'package:pijetin/view/widget/empty.dart';

class AccountActivityUserPage extends StatelessWidget {
  AccountActivityUserPage({super.key});
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              header(),
              24.0.height,
              Obx(() {
                return Expanded(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.listActivity.isEmpty
                          ? const Center(
                              child: Empty(title: "No Data Activity"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listActivity
                                  .take(10)
                                  .toList()
                                  .length,
                              itemBuilder: (context, index) {
                                return ActivityItem(
                                  activityHistories:
                                      controller.listActivity.toList()[index],
                                );
                              },
                            ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        12.0.width,
        Text(
          'Account Activity',
          style: AppFont.medium16,
        ),
      ],
    );
  }
}
