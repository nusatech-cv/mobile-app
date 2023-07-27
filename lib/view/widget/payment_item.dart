import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/utils/utils.dart';

class PaymentItem extends StatelessWidget {
  final String? selectedPayment;
  final List<String> payment;
  final Function(String)? onTap;
  const PaymentItem({
    super.key,
    this.selectedPayment,
    required this.payment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: payment
            .map(
              (e) => GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!(e);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.strokeColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        WidgetHelper.paymentImage(e.toUpperCase()),
                        height: 38.h,
                      ),
                      12.0.width,
                      Text(
                        e,
                        style: AppFont.medium16,
                      ),
                      const Spacer(),
                      Icon(
                        e == selectedPayment
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}
