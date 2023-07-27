import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/theme.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_controller.dart';
import 'package:pijetin/view/pages/user/therapist_profile/therapist_profile_page.dart';
import 'package:pijetin/view/widget/card_therapist.dart';
import 'package:pijetin/view/widget/empty.dart';

class TopTherapist extends StatelessWidget {
  final void Function()? onTapSeeAll;
  TopTherapist({
    super.key,
    this.onTapSeeAll,
  });

  final TherapistController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Therapist",
                  style: AppFont.medium16.copyWith(
                    color: AppColor.textStrong,
                  ),
                ),
                (controller.therapistListInitial.isEmpty ||
                        controller.isLoading.value)
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: onTapSeeAll,
                        child: Text(
                          "See All",
                          style: AppFont.medium16.copyWith(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
              ],
            ),
            controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.therapistListInitial.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.h),
                          child: const Empty(
                              title: "No Data",
                              subtitle:
                                  "There is No Top Therapist Available Yet"),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.therapistListInitial
                            .take(5)
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          final therapist = controller.therapistListInitial
                              .take(5)
                              .toList()[index];

                          return CardTherapist(
                            onTap: () =>
                                Get.to(TherapistPage(therapist: therapist)),
                            therapist: therapist,
                            isOnline: true,
                            isAppointment: true,
                          );
                        },
                      )
          ],
        ),
      );
    });
  }
}
