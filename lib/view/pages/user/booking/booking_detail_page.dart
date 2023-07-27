import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/location_controller.dart';
import 'package:pijetin/domain/controller/user_controller/order_detail_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/booking/payment_booking_page.dart';
import 'package:pijetin/view/widget/map_view.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../../widget/rating.dart';

class DetailBookingPage extends StatefulWidget {
  final int id;
  const DetailBookingPage({
    required this.id,
    super.key,
  });

  @override
  State<DetailBookingPage> createState() => _DetailBookingPageState();
}

class _DetailBookingPageState extends State<DetailBookingPage> {
  final LocationController locationController = Get.find();

  late OrderDetailController controller;
  String decodeLocation = "";

  @override
  void initState() {
    controller = Get.put(OrderDetailController(widget.id));
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
                        : const SizedBox(),
                  ],
                ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(24.h),
            decoration: BoxDecoration(color: AppColor.background, boxShadow: [
              BoxShadow(
                  color: AppColor.strokeColor,
                  spreadRadius: 1.h,
                  blurRadius: 1.h)
            ]),
            child: controller.orderUserDetail.value.orderStatus ==
                    "waiting_confirmation"
                ? SecondaryButton(
                    title: "Cancel Order",
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
                        builder:
                            (context, scrollController, bottomSheetOffset) =>
                                bottomSheetCancel(),
                        anchors: [0, 0.5, 1],
                        isSafeArea: true,
                      );
                    })
                : controller.orderUserDetail.value.orderStatus ==
                        "waiting_payment"
                    ? PrimaryButton(
                        title: "Pay Appointment",
                        onPressed: () {
                          Get.to(() => PaymentBookingPage(
                                orderDetail: controller.orderUserDetail.value,
                              ));
                        })
                    : controller.orderUserDetail.value.orderStatus == "done"
                        ? (controller.orderUserDetail.value.ratings != null
                            ? SecondaryButton(
                                title: "Booking Appointment Again",
                                onPressed: () {
                                  Get.back();
                                })
                            : PrimaryButton(
                                title: 'Give Feedback',
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.r),
                                            topRight: Radius.circular(16.r))),
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: bottomSheetConfirmation(),
                                      );
                                    },
                                  );
                                }))
                        : const SizedBox(),
          ));
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
                controller.cancelHistory();
              }),
          16.0.height,
          SecondaryButtonV2(title: 'Discard', onPressed: () {})
        ],
      ),
    );
  }

  Container bottomSheetConfirmation() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Feedback',
              style: AppFont.medium24,
            ),
          ),
          16.0.height,
          Row(
            children: [
              Container(
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor,
                    image: DecorationImage(
                        image: NetworkImage(controller
                            .orderUserDetail.value.therapistAvatar!.url!),
                        fit: BoxFit.cover)),
              ),
              14.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.orderUserDetail.value.therapistName ?? '',
                    style: AppFont.medium12,
                  ),
                  Text(
                    controller.orderUserDetail.value.serviceName ?? '',
                    style: AppFont.reguler12.copyWith(color: AppColor.textSoft),
                  ),
                ],
              ),
            ],
          ),
          16.0.height,
          Center(
            child: RatingBar(
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Image.asset(AppIcon.starIcon),
                half: Image.asset(AppIcon.starOutlineIcon),
                empty: Image.asset(AppIcon.starOutlineIcon),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                controller.rating.value = rating;
              },
            ),
          ),
          16.0.height,
          Text(
            "Note For Therapist",
            style: AppFont.medium14,
          ),
          8.0.height,
          TextFormField(
            maxLines: 2,
            controller: controller.note,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                hintText: 'Note',
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.textSoft),
                    borderRadius: BorderRadius.circular(10))),
          ),
          16.0.height,
          PrimaryButton(
              title: 'Confirm',
              loading: controller.isLoadingFeedback.value,
              onPressed: () {
                controller.toFeedback();
              }),
        ],
      ),
    );
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
                    .format(controller.orderUserDetail.value.totalPrice),
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
                AppImage.paymentOvo,
                width: 48.w,
              ),
              12.0.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ovo Payment',
                    style: AppFont.medium16,
                  ),
                  Text(
                    '08993562863',
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
          16.0.height,
          Text(
            controller.orderUserDetail.value.note ?? "",
            style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
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
                      "${DateFormat('dd/MM/yyyy').format(controller.orderUserDetail.value.updatedAt!)} • ${DateFormat('hh:mm a').format(controller.orderUserDetail.value.appointmentDate!)} - ${controller.rangeDuration()}",
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
                "${controller.orderUserDetail.value.id}",
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
                    controller.orderUserDetail.value.updatedAt ??
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
                'Status :',
                style: AppFont.semibold16,
              ),
              Text(
                (controller.orderUserDetail.value.orderStatus ?? '')
                        .replaceAll("_", " ")
                        .capitalize ??
                    '',
                style: AppFont.semibold16.copyWith(
                    color: controller.orderUserDetail.value.orderStatus ==
                            'done'
                        ? AppColor.greenColor
                        : (controller.orderUserDetail.value.orderStatus ==
                                    'cancel' ||
                                controller.orderUserDetail.value.orderStatus ==
                                    'expired')
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
