import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/user_controller/payment_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/widget.dart';

class Step1PaymentEwallet extends StatelessWidget {
  Step1PaymentEwallet({super.key, required this.id});
  final int id;
  final PaymentController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
              24.0.height,
              Text(
                'Enter your number linked to ${controller.selectedPayment.value}',
                style: AppFont.medium16,
              ),
              16.0.height,
              InputText(
                controller: controller.numberController,
                hintText:
                    'Input ${controller.selectedPayment.value.toLowerCase()} number',
                keyboardType: TextInputType.number,
                onChange: controller.onNumberChange,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              16.0.height,
              Text(
                '1. Open ${controller.selectedPayment.value} Apps and check notification to complete payment',
                style: AppFont.medium12.copyWith(
                  color: AppColor.textSoft,
                ),
              ),
              Text(
                '2. Make sure you make a payment within 55 minutes to avoid automatic cancellation',
                style: AppFont.medium12.copyWith(
                  color: AppColor.textSoft,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return PrimaryButton(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          disable: controller.disablebutton2.value,
          loading: controller.isLoading.value,
          title: 'Pay Appointment',
          onPressed: () {
            controller.postPayment(id);
          },
        );
      }),
    );
  }
}
