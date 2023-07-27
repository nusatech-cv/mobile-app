import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/therapist/therapist.dart';
import 'package:pijetin/data/model/user/therapist/therapist_detail.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_detail_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/booking/booking_page.dart';
import 'package:pijetin/view/widget/card_therapist.dart';
import 'package:pijetin/view/widget/widget.dart';

class TherapistPage extends StatefulWidget {
  final Therapist therapist;
  const TherapistPage({super.key, required this.therapist});

  @override
  State<TherapistPage> createState() => _TherapistPageState();
}

class _TherapistPageState extends State<TherapistPage> {
  final TherapistDetailController controller =
      Get.put(TherapistDetailController());

  @override
  void initState() {
    controller.getTherapists(widget.therapist.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: WidgetHelper.appBar(title: "Therapist Profile"),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: AppColor.background, boxShadow: [
            BoxShadow(
                color: AppColor.strokeColor, spreadRadius: 1.h, blurRadius: 1.h)
          ]),
          padding: const EdgeInsets.all(24),
          child: PrimaryButton(
              title: "Start",
              onPressed: () {
                Get.to(() => BookingPage(
                      therapist: controller.therapist.value,
                    ));
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardTherapist(
                        therapist: widget.therapist,
                        isOnline: false,
                        isAppointment: false,
                        showRating: false,
                        profileHeight: 75.h,
                      ),
                      24.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          summaryTherapist(
                              type: "Client",
                              total: controller.therapist.value.clientTotal
                                  .toString(),
                              icon: AppIcon.clientIcon),
                          summaryTherapist(
                              type: "Years Experience",
                              total: controller.therapist.value.experienceYears
                                  .toString(),
                              icon: AppIcon.experienceIcon),
                          summaryTherapist(
                              type: "Rating",
                              total: controller.therapist.value.averageRating ==
                                      null
                                  ? "0"
                                  : controller.therapist.value.averageRating
                                      .toString(),
                              icon: AppIcon.halfStar),
                          summaryTherapist(
                              type: "Review",
                              total: controller.therapist.value.ratings!.length
                                  .toString(),
                              icon: AppIcon.reviewIcon),
                        ],
                      ),
                      24.0.height,
                      Text(
                        "Working Time",
                        style: AppFont.medium16,
                      ),
                      8.0.height,
                      Text(
                        "${WidgetHelper.day(controller.therapist.value.startDay ?? 0)} - ${WidgetHelper.day(controller.therapist.value.endDay ?? 0)}, ${controller.therapist.value.startTime} - ${controller.therapist.value.endTime}",
                        style:
                            AppFont.medium14.copyWith(color: AppColor.textSoft),
                      ),
                      24.0.height,
                      _reviewsClient(),
                    ],
                  ),
                ),
        ),
      );
    });
  }

  Column _reviewsClient() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews Client",
              style: AppFont.medium16,
            ),
            Text(
              "See All",
              style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
            ),
          ],
        ),
        16.0.height,
        Column(
          children: controller.therapist.value.ratings!
              .map((e) => _reviewItem(e))
              .toList(),
        )
      ],
    );
  }

  Widget _reviewItem(Rating rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: NetworkImage(rating.userAvatar!)),
                ),
              ),
              14.0.width,
              Text(
                "${rating.userFirstName} ${rating.userLastName}",
                style: AppFont.semibold16,
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColor.background,
                  border: Border.all(
                    color: AppColor.primaryColor,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppIcon.starIcon,
                      height: 12,
                      width: 12,
                    ),
                    7.0.width,
                    Text(
                      rating.rating.toString(),
                      style: AppFont.semibold14
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          8.0.height,
          Text(
            rating.note ?? "",
            style: AppFont.medium14.copyWith(color: AppColor.textSoft),
          )
        ],
      ),
    );
  }

  Column summaryTherapist({String? total, String? type, String? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 64.w,
          width: 64.w,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColor.cardColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            icon ?? AppIcon.clientIcon,
          ),
        ),
        8.0.height,
        Text(
          total ?? "200+",
          style: AppFont.medium14,
        ),
        8.0.height,
        Text(
          type ?? "Client",
          style: AppFont.medium12.copyWith(color: AppColor.textSoft),
        ),
      ],
    );
  }
}
