import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/utils/utils.dart';

import '../../../../../config/config.dart';
import '../../../../widget/widget.dart';

class AppointmentFinished extends StatelessWidget {
  const AppointmentFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.appBar(
        title: 'Appointment Finished',
        onTap: () {
          Get.close(1);
        },
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.ilustration3,
              width: 251.w,
            ),
            24.0.height,
            Text(
              'Appointment has been finished',
              style: AppFont.medium16,
            ),
            8.0.height,
            Text(
              'Make sure your payment already received ',
              style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.h),
        decoration: BoxDecoration(color: AppColor.background, boxShadow: [
          BoxShadow(
              color: AppColor.strokeColor, spreadRadius: 1.h, blurRadius: 1.h)
        ]),
        child: PrimaryButton(
          title: 'Close',
          onPressed: () {
            Get.close(1);
          },
        ),
      ),
    );
  }
}
