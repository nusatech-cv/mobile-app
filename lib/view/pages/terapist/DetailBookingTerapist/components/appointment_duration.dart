import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/terapist_controller/appoinment_detail_controller.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/empty.dart';

import '../../../../../config/config.dart';
import '../../../../widget/widget.dart';

class AppointentDuration extends StatelessWidget {
  AppointentDuration({super.key});
  final AppointmentDetailController controller = Get.find();

  formatedTime() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(controller.myDuration.value.inHours.remainder(24));
    final minutes =
        strDigits(controller.myDuration.value.inMinutes.remainder(60));
    final seconds =
        strDigits(controller.myDuration.value.inSeconds.remainder(60));
    return "$hours : $minutes : $seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: WidgetHelper.appBar(
          title: 'Appointment Duration',
          onTap: () {
            Get.back();
            controller.stopTimer();
          },
        ),
        body: Center(
          child: controller.myDuration.value.inSeconds == 0
              ? const Empty(title: "Time is over")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Timme Countdown",
                      style: AppFont.reguler14,
                    ),
                    24.0.height,
                    Text(
                      formatedTime(),
                      style: AppFont.bold48
                          .copyWith(color: const Color(0xff2C2C63)),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(24.h),
          decoration: BoxDecoration(color: AppColor.background, boxShadow: [
            BoxShadow(
                color: AppColor.strokeColor, spreadRadius: 1.h, blurRadius: 1.h)
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                title: 'Finish Now',
                onPressed: () {
                  controller.changeStateOrder(
                      StateOrder.endOrder, "Service has been completed");
                },
              ),
              10.0.height,
              SecondaryButton(
                  title: controller.isActive.value == true ? 'Pause' : "Start",
                  onPressed: () {
                    controller.isActive.value == true
                        ? controller.stopTimer()
                        : controller.startTimer();
                  })
            ],
          ),
        ),
      );
    });
  }
}
