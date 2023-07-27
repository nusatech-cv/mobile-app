import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/config/theme/theme.dart';
import 'package:pijetin/data/model/user/therapist/therapist.dart';
import 'package:pijetin/data/src/src.dart';
import 'package:pijetin/utils/utils.dart';

class CardTherapist extends StatelessWidget {
  final Therapist therapist;
  final bool? isOnline;
  final bool isAppointment;
  final bool isShowFavorite;
  final void Function()? onTap;
  final bool showRating;
  final double? profileHeight;
  final double? profileWidth;
  const CardTherapist(
      {super.key,
      required this.therapist,
      this.isOnline,
      this.isAppointment = false,
      this.isShowFavorite = false,
      this.showRating = true,
      this.onTap,
      this.profileHeight,
      this.profileWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColor.strokeColor,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: profileHeight ?? 60.h,
                      width: profileWidth ?? 63.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: therapist.photo!.url != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(therapist.photo!.url!))
                            : const DecorationImage(
                                image: AssetImage(AppImage.therapistPic),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
                12.0.height,
                showRating
                    ? Row(
                        children: [
                          Image.asset(
                            AppIcon.starIconGreen,
                            height: 17,
                            width: 17,
                          ),
                          Text(
                            (therapist.averageRating == null ||
                                    therapist.averageRating == 0.0)
                                ? "0.0"
                                : therapist.averageRating.toString(),
                            style: AppFont.medium14
                                .copyWith(color: AppColor.textSoft),
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
            32.0.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    therapist.firstName != null || therapist.lastName != null
                        ? "${therapist.firstName} ${therapist.lastName}"
                        : "",
                    style:
                        AppFont.medium18.copyWith(color: AppColor.textStrong),
                  ),
                  isAppointment
                      ? Column(
                          children: [
                            Text(
                              "${therapist.services!.isEmpty ? "" : therapist.services!.first.name ?? ""} ${therapist.readableLocation ?? ""}",
                              style: AppFont.medium12
                                  .copyWith(color: AppColor.textSoft),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: therapist.services!
                                  .map(
                                    (e) => Text(
                                      "${e.name}, ",
                                      style: AppFont.medium12
                                          .copyWith(color: AppColor.textSoft),
                                    ),
                                  )
                                  .toList(),
                            ),
                            8.0.height,
                            Text(
                              therapist.readableLocation ?? "",
                              style: AppFont.medium12
                                  .copyWith(color: AppColor.textSoft),
                            ),
                          ],
                        ),
                  8.0.height,
                  isAppointment
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
                          decoration: BoxDecoration(
                              color: AppColor.cardColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "Appointment",
                            style: AppFont.medium12
                                .copyWith(color: AppColor.textStrong),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            isShowFavorite
                ? Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: 16.w,
                      color: AppColor.textStrong,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
