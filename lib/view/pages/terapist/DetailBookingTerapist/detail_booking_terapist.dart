import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/terapist_controller/appoinment_detail_controller.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/map_view.dart';
import 'package:pijetin/view/widget/rating.dart';
import 'package:pijetin/view/widget/widget.dart';

class DetailBookingTerapist extends StatefulWidget {
  const DetailBookingTerapist({super.key, required this.id});
  final int id;
  @override
  State<DetailBookingTerapist> createState() => _DetailBookingTerapistState();
}

class _DetailBookingTerapistState extends State<DetailBookingTerapist> {
  late final AppointmentDetailController controller;

  @override
  void initState() {
    controller = Get.put(AppointmentDetailController(id: widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: WidgetHelper.appBar(
          title: "Appointment Details",
        ),
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  32.0.height,
                  appointentInfo(),
                  24.0.height,
                  apointemntDuration(),
                  24.0.height,
                  location(context),
                  24.0.height,
                  controller.orderUserDetail.value.payment != null
                      ? Column(
                          children: [
                            paymentMethod(),
                            24.0.height,
                            paymentSummary(),
                            24.0.height,
                          ],
                        )
                      : const SizedBox(),
                  controller.orderUserDetail.value.ratings != null
                      ? Column(
                          children: [
                            feedback(),
                            24.0.height,
                          ],
                        )
                      : const SizedBox()
                ],
              ),
        bottomNavigationBar: (controller.orderUserDetail.value.orderStatus !=
                    "waiting_confirmation" &&
                controller.orderUserDetail.value.orderStatus !=
                    "appointment_start" &&
                controller.orderUserDetail.value.orderStatus != "paid")
            ? const SizedBox()
            : Container(
                padding: EdgeInsets.all(24.h),
                decoration: BoxDecoration(
                    color: AppColor.background,
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.strokeColor,
                          spreadRadius: 1.h,
                          blurRadius: 1.h)
                    ]),
                child: controller.orderUserDetail.value.orderStatus == "paid"
                    ? PrimaryButton(
                        title: "Start",
                        onPressed: () {
                          controller.changeStateOrder(
                              StateOrder.startOrder, "Service has started");
                        })
                    : controller.orderUserDetail.value.orderStatus ==
                            "appointment_start"
                        ? PrimaryButton(
                            title: 'Finish Now',
                            onPressed: () {
                              controller.changeStateOrder(StateOrder.endOrder,
                                  "Service has been completed");
                            },
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrimaryButton(
                                  title: 'Confirm',
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
                                      builder: (context, scrollController,
                                              bottomSheetOffset) =>
                                          bottomSheetConfirmation(),
                                      anchors: [0, 0.5, 1],
                                      isSafeArea: true,
                                    );
                                  }),
                              10.0.height,
                              SecondaryButtonV2(
                                  title: 'Cancel',
                                  onPressed: () {
                                    controller.changeStateOrder(
                                        StateOrder.cancel,
                                        "order has been canceled");
                                  })
                            ],
                          ),
              ),
      );
    });
  }

  Container feedback() {
    return Container(
      padding: EdgeInsets.all(
        16.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.background,
          border: Border.all(width: 2.h, color: AppColor.strokeColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FeedBack',
            style: AppFont.semibold16,
          ),
          16.0.height,
          Text(
            controller.orderUserDetail.value.ratings?.note ?? '',
            style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
          ),
          16.0.height,
          Container(
            width: double.infinity,
            height: 64.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColor.strokeColor),
            child: Center(
              child: Rating(
                rate: (controller.orderUserDetail.value.ratings!.rating ?? 0)
                    .toDouble(),
                size: 32.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container bottomSheetConfirmation() {
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
            'Confirm Appointment',
            style: AppFont.semibold16,
          ),
          32.0.height,
          Image.asset(
            AppIcon.warningIcon,
            width: 56.w,
          ),
          32.0.height,
          Text(
            'Are you sure want to accept\nthis appointment',
            style: AppFont.medium16.copyWith(color: AppColor.textSoft),
            textAlign: TextAlign.center,
          ),
          32.0.height,
          PrimaryButton(
              title: 'Confirm',
              onPressed: () {
                controller.changeStateOrder(
                    StateOrder.accept, "Order has been confirmed");
              }),
          16.0.height,
          SecondaryButtonV2(title: 'Cancel', onPressed: () {})
        ],
      ),
    );
  }

  Container paymentSummary() {
    return Container(
      padding: EdgeInsets.all(
        16.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.background,
          border: Border.all(width: 2.h, color: AppColor.strokeColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: AppFont.semibold16,
          ),
          16.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppFont.reguler16.copyWith(color: AppColor.textSoft),
              ),
              Text(
                NumberFormat.currency(
                        symbol: 'Rp ', decimalDigits: 2, locale: 'id_ID')
                    .format(double.parse(controller
                        .orderUserDetail.value.payment!.amountPaid
                        .toString())),
                style: AppFont.semibold24,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container paymentMethod() {
    return Container(
      padding: EdgeInsets.all(
        16.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.background,
          border: Border.all(width: 2.h, color: AppColor.strokeColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: AppFont.semibold16,
          ),
          16.0.height,
          Row(
            children: [
              Image.asset(
                WidgetHelper.paymentImage(
                  controller.orderUserDetail.value.payment!.paymentMethod!
                      .toUpperCase(),
                ),
                width: 50.w,
              ),
              12.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.orderUserDetail.value.payment!.paymentMethod ??
                        '',
                    style: AppFont.medium16,
                  ),
                  Text(
                    controller.orderUserDetail.value.payment!.toAccount ?? '',
                    style: AppFont.medium12.copyWith(color: AppColor.textSoft),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container location(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(
        16.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.background,
          border: Border.all(width: 2.h, color: AppColor.strokeColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Locations",
            style: AppFont.semibold16,
          ),
          16.0.height,
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColor.primaryColor,
                size: 32.w,
              ),
              16.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style:
                          AppFont.reguler14.copyWith(color: AppColor.textSoft),
                    ),
                    Text(controller.decodeLocation.value,
                        style: AppFont.semibold16)
                  ],
                ),
              )
            ],
          ),
          16.0.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CommonStaticMap(
              centerLocation: Location(
                  controller.orderUserDetail.value.location!.x!,
                  controller.orderUserDetail.value.location!.y!),
              ontap: () {
                Get.to(() => MapViewPage(
                      point: LatLng(
                          controller.orderUserDetail.value.location!.x!,
                          controller.orderUserDetail.value.location!.y!),
                    ));
              },
            ),
          ),
          16.0.height,
          Text(
            "Note",
            style: AppFont.semibold16,
          ),
          8.0.height,
          Text(
            controller.orderUserDetail.value.note ?? '',
            style: AppFont.medium14.copyWith(color: AppColor.textSoft),
          ),
        ],
      ),
    );
  }

  Container apointemntDuration() {
    return Container(
      padding: EdgeInsets.all(
        16.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.background,
          border: Border.all(width: 2.h, color: AppColor.strokeColor)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Appointment Details",
                style: AppFont.semibold16,
              ),
              Icon(
                Icons.more_horiz,
                size: 24.w,
                color: AppColor.textSoft,
              )
            ],
          ),
          16.0.height,
          Row(
            children: [
              Image.asset(
                AppIcon.durationIcon,
                width: 32.w,
              ),
              16.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration',
                      style:
                          AppFont.reguler14.copyWith(color: AppColor.textSoft),
                    ),
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(controller.orderUserDetail.value.appointmentStart ?? DateTime.now())} • ${DateFormat('HH:mm').format(controller.orderUserDetail.value.appointmentDate ?? DateTime.now())} - ${DateFormat('HH:mm').format((controller.orderUserDetail.value.appointmentDate ?? DateTime.now()).add(Duration(minutes: controller.orderUserDetail.value.appointmentDuration ?? 0)))} ",
                      style: AppFont.semibold16,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container appointentInfo() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColor.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.orderUserDetail.value.serviceName ?? '',
            style: AppFont.semibold16,
          ),
          16.0.height,
          Text(
            controller.orderUserDetail.value.serviceDescription ?? '',
            style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
          ),
          16.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointment ID :',
                style: AppFont.semibold16,
              ),
              Text(
                controller.orderUserDetail.value.id.toString(),
                style: AppFont.semibold16,
              )
            ],
          ),
          16.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointment On :',
                style: AppFont.semibold16,
              ),
              Text(
                DateFormat("dd/MM/yyyy").format(
                    controller.orderUserDetail.value.appointmentDate ??
                        DateTime.now()),
                style: AppFont.semibold16,
              )
            ],
          ),
          16.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status:',
                style: AppFont.semibold16,
              ),
              Text(
                (controller.orderUserDetail.value.orderStatus ?? '')
                        .replaceAll("_", " ")
                        .capitalize ??
                    '',
                style: AppFont.semibold16.copyWith(
                    color: controller.orderUserDetail.value.orderStatus ==
                            "done"
                        ? AppColor.greenColor
                        : (controller.orderUserDetail.value.orderStatus ==
                                    "cancel" ||
                                controller.orderUserDetail.value.orderStatus ==
                                    "expired")
                            ? AppColor.primaryColor
                            : AppColor.yellowColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
