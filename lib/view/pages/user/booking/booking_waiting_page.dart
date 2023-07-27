import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/user_controller/booking_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/booking/payment_booking_page.dart';

import '../../../widget/widget.dart';

class BookingWaitingPage extends StatelessWidget {
  BookingWaitingPage({super.key});

  final BookingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: WidgetHelper.appBar(
          title: 'Waiting Confirmation',
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: AppColor.background, boxShadow: [
            BoxShadow(
                color: AppColor.strokeColor, spreadRadius: 1.h, blurRadius: 1.h)
          ]),
          padding: const EdgeInsets.all(24),
          child: controller.isBookingConfirmed.value
              ? PrimaryButton(
                  title: "Pay Appointment",
                  onPressed: () {
                    Get.to(() => PaymentBookingPage(
                          orderDetail: controller.order.value,
                        ));
                  })
              : SecondaryButton(
                  title: "Cancel Appointment",
                  onPressed: () {
                    showFlexibleBottomSheet(
                      minHeight: 0,
                      initHeight: 0.47,
                      maxHeight: 1,
                      bottomSheetColor: Colors.transparent,
                      decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r))),
                      context: context,
                      builder: (context, scrollController, bottomSheetOffset) =>
                          bottomSheetCancel(),
                      anchors: [0, 0.5, 1],
                      isSafeArea: true,
                    );
                    // controller.changeStateOrder(StateOrder.cancel);
                  }),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getOrder();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    controller.isBookingConfirmed.value
                        ? AppImage.bookingConfirmed
                        : AppImage.bookingWaiting,
                    width: 300.w,
                    height: 225.w,
                  ),
                  24.0.height,
                  Text(
                    controller.isBookingConfirmed.value
                        ? "Therapist Accepts Appointment"
                        : "Waiting Confirmation Therapist",
                    textAlign: TextAlign.center,
                    style: AppFont.medium16,
                  ),
                  8.0.height,
                  Text(
                    controller.isBookingConfirmed.value
                        ? "Your appointment has been approved by the therapist, please make a payment according to the amount stated"
                        : "Waiting for therapist to accept your appointment, this proccess not fill long",
                    textAlign: TextAlign.center,
                    style: AppFont.medium14.copyWith(color: AppColor.textSoft),
                  ),
                  80.0.height,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Container bottomSheetCancel() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: Column(
        children: [
          Text(
            'Cancel Appointment',
            style: AppFont.semibold16,
          ),
          32.0.height,
          Image.asset(
            AppIcon.warningIcon,
            width: 56.w,
          ),
          32.0.height,
          Text(
            'Are you sure want to cancel\nthis appointment',
            style: AppFont.medium16.copyWith(color: AppColor.textSoft),
            textAlign: TextAlign.center,
          ),
          32.0.height,
          PrimaryButton(
              title: 'Confirm',
              onPressed: () {
                controller.changeStateOrder();
              }),
          16.0.height,
          SecondaryButtonV2(title: 'Discard', onPressed: () {})
        ],
      ),
    );
  }
}
