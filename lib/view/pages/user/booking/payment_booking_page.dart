import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/user_controller/payment_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/booking/components/step1_payment_e_wallet.dart';
import 'package:pijetin/view/widget/empty.dart';
import 'package:pijetin/view/widget/payment_item.dart';
import 'package:pijetin/view/widget/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../data/model/user/order_user/order_user_detail.dart';

class PaymentBookingPage extends StatelessWidget {
  PaymentBookingPage({super.key, required this.orderDetail});
  final OrderDetail orderDetail;
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            child: Column(
              children: [
                header(),
                24.0.height,
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Select Payment Method',
                        style: AppFont.medium16,
                      ),
                      16.0.height,
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.listPayment.isEmpty
                              ? const Center(
                                  child: Empty(
                                  title: "No Payment Found",
                                  subtitle:
                                      "Perhaps server is under maintenance",
                                  width: 200,
                                ))
                              : PaymentItem(
                                  selectedPayment:
                                      controller.selectedPayment.value,
                                  onTap: (value) {
                                    // controller.selectedPayment.value =
                                    //     PaymentMethods();
                                    controller.changeSelectedPayment(value);
                                  },
                                  payment: controller.listPayment,
                                ),
                      16.0.height,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColor.strokeColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Summary',
                              style: AppFont.medium14,
                            ),
                            16.0.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${orderDetail.appointmentDuration} minutes ${orderDetail.serviceName}',
                                  style: AppFont.medium12,
                                ),
                                Text(
                                  NumberFormat.currency(
                                          symbol: 'Rp ',
                                          decimalDigits: 2,
                                          locale: 'id_ID')
                                      .format(orderDetail.totalPrice),
                                  style: AppFont.medium12,
                                ),
                              ],
                            ),
                            // 8.0.height,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: PrimaryButton(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          title: 'Pay Appointment',
          disable: controller.disablebutton1.value,
          onPressed: () {
            controller.selectedPayment.value == 'Ovo'
                ? Get.to(() => Step1PaymentEwallet(
                      id: orderDetail.id!,
                    ))
                : controller.selectedPayment.value == 'Dana'
                    ? Get.to(() => Step1PaymentEwallet(
                          id: orderDetail.id!,
                        ))
                    : sheetBidr(context);
          },
        ),
      );
    });
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
          'Payment',
          style: AppFont.medium16,
        ),
      ],
    );
  }

  Future<dynamic> sheetBidr(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColor.background,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Payment BIDR',
                    style: AppFont.semibold16,
                  ),
                ),
                16.0.height,
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'QR Code ',
                          style: AppFont.medium16,
                        ),
                      ),
                      12.0.height,
                      Center(
                        child: QrImageView(
                          padding: EdgeInsets.all(5.w),
                          backgroundColor: Colors.white,
                          data:
                              '0x260fF8c1D0247bc746EDB8483fcD14AA28eEa9EF47bc746EDB8483fcD14AA28eEa9EF',
                          size: 125.w,
                        ),
                      ),
                      16.0.height,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.cardColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '0x260fF8c1D0247bc746EDB8483fcD14AA28eEa9EF47bc746EDB8483fcD14AA28eEa9EF',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.medium12,
                              ),
                            ),
                            8.0.width,
                            GestureDetector(
                              onTap: () => handleCopy(
                                  data:
                                      '0x260fF8c1D0247bc746EDB8483fcD14AA28eEa9EF47bc746EDB8483fcD14AA28eEa9EF'),
                              child: Image.asset(
                                AppIcon.copy,
                                width: 24.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          cryptoItem(
                            onTap: () {},
                            image: AppImage.cryptoMetamask,
                          ),
                          cryptoItem(
                            onTap: () {},
                            image: AppImage.cryptoTrustWallet,
                          ),
                          cryptoItem(
                            onTap: () {},
                            image: AppImage.cryptoOkx,
                          ),
                          cryptoItem(
                            onTap: () {},
                            image: AppImage.cryptoBitkeep,
                          ),
                          cryptoItem(
                            onTap: () {},
                            image: AppImage.cryptoAlpha,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget cryptoItem({required String image, Function()? onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          width: 2.w,
          color: AppColor.primaryColor,
        ),
      ),
      width: 42.w,
      height: 42.h,
      child: Image.asset(
        image,
      ),
    );
  }
}
