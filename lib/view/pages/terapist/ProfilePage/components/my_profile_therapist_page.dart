import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/view/widget/static_map.dart';

import '../../../../../domain/controller/terapist_controller/profile_terapist_controller.dart';
import '../../../../../utils/utils.dart';
import '../../../../widget/map_picker.dart';

class MyProfileTherapistPage extends StatelessWidget {
  MyProfileTherapistPage({super.key});
  final ProfileTherapistController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget cardItem(String text) {
      return Container(
        width: double.infinity,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1, color: AppColor.borderColor)),
        child: Text(
          text,
          style: AppFont.medium12.copyWith(color: AppColor.textSoft),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              24.0.height,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 124.w,
                          height: 124.w,
                          child: ClipOval(
                            child: Image.network(
                              controller.user.value.therapist?.photo?.url ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      16.0.height,
                      Text(
                        "First Name",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(controller.user.value.firstName ?? ''),
                      8.0.height,
                      Text(
                        "Last Name",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(controller.user.value.lastName ?? ''),
                      8.0.height,
                      Text(
                        "Role",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(controller.user.value.role ?? ''),
                      8.0.height,
                      Text(
                        "Email",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(controller.user.value.email ?? ''),
                      8.0.height,
                      Text(
                        "Gender",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem((controller.user.value.therapist!.gender ?? '')
                              .capitalize ??
                          ''),
                      8.0.height,
                      Text(
                        "Services",
                        style: AppFont.medium14,
                      ),
                      controller.user.value.services!.isEmpty
                          ? cardItem('No Service')
                          : Column(
                              children: controller.user.value.services!
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: cardItem(e.name ?? ''),
                                      ))
                                  .toList(),
                            ),
                      8.0.height,
                      Text(
                        "Experience",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(
                          ('${controller.user.value.therapist!.experienceYears ?? 0} years')
                                  .capitalize ??
                              ''),
                      8.0.height,
                      Text(
                        "Work Time",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      cardItem(
                          "${WidgetHelper.day(controller.user.value.therapist!.startDay ?? 0)} - ${WidgetHelper.day(controller.user.value.therapist!.endDay ?? 0)}"),
                      8.0.height,
                      cardItem(
                          "${controller.user.value.therapist!.startTime} - ${controller.user.value.therapist!.endTime}"),
                      8.0.height,
                      Text(
                        'Address',
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_sharp,
                            color: AppColor.primaryColor,
                          ),
                          8.0.width,
                          Expanded(
                            child: Text(
                              controller.user.value.address ?? '',
                              overflow: TextOverflow.clip,
                              style: AppFont.reguler12,
                            ),
                          ),
                        ],
                      ),
                      8.0.height,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CommonStaticMap(
                          centerLocation: Location(
                              controller.user.value.therapist!.location!.x!,
                              controller.user.value.therapist!.location!.y!),
                          ontap: () {
                            Get.to(() => MapPicker(
                                  point: LatLng(
                                      controller
                                          .user.value.therapist!.location!.x!,
                                      controller
                                          .user.value.therapist!.location!.y!),
                                  ontap: (value) {
                                    // controller.setLocation(value);
                                  },
                                ));
                          },
                        ),
                      ),
                      24.0.height
                    ],
                  ),
                ),
              )
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
          'My Profile',
          style: AppFont.medium16,
        ),
      ],
    );
  }
}
