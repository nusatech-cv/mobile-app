import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/user_controller/payment_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/widget.dart';

class Step2PaymentEwallet extends StatelessWidget {
  Step2PaymentEwallet({super.key, required this.id});
  final int id;
  final PaymentController controller = Get.find();
  formatedTime() {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes =
        strDigits(controller.myDuration.value.inMinutes.remainder(60));
    final seconds =
        strDigits(controller.myDuration.value.inSeconds.remainder(60));
    return "$minutes : $seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.ilustration5,
              ),
              24.0.height,
              Text(
                'Waiting Payment',
                style: AppFont.medium16,
              ),
              8.0.height,
              Text(
                'Click into the OVO application and open the notification to continue your payment in time',
                textAlign: TextAlign.center,
                style: AppFont.medium14.copyWith(
                  color: AppColor.textSoft,
                ),
              ),
              8.0.height,
              Obx(() {
                return Text(
                  formatedTime(),
                  style: AppFont.medium16,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PrimaryButton(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        title: 'I Already Pay',
        onPressed: () {
          controller.confirmPayment(id: id);
        },
      ),
    );
  }
}
