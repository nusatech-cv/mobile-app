import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/user_controller/booking_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/primary_button.dart';

class ReviewBookingPage extends StatelessWidget {
  ReviewBookingPage({super.key});

  final BookingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.appBar(title: 'Review Appointment'),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(color: AppColor.background, boxShadow: [
            BoxShadow(
                color: AppColor.strokeColor, spreadRadius: 1.h, blurRadius: 1.h)
          ]),
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            return PrimaryButton(
                loading: controller.isLoading.value,
                title: "Request Appointment",
                onPressed: () {
                  controller.postBooking();
                });
          })),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            Text(
              "Check your appointment",
              style: AppFont.medium16,
            ),
            10.0.height,
            Text(
              "Please double check the information below before proceeding",
              style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
            ),
            24.0.height,
            _reviewItem(
                icon: AppIcon.date,
                data:
                    "${DateFormat("dd MMM").format(controller.selectedDate.value)} between ${controller.selectedHours.value} - ${controller.rangeDuration()}"),
            _reviewItem(
                icon: AppIcon.locationIcon,
                data: controller.addressPicker.value),
            _reviewItem(icon: AppIcon.note, data: controller.note.value.text),
          ],
        ),
      ),
    );
  }

  Widget _reviewItem({String? icon, String? data, void Function()? onTap}) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              icon ?? AppIcon.date,
              height: 24.w,
              width: 24.w,
            ),
            12.0.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          data ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.medium14,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Change",
                          style: AppFont.medium14
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
