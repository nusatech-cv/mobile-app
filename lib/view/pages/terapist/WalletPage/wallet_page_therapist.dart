import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/payment/history_payment_therapist.dart';
import 'package:pijetin/domain/controller/terapist_controller/wallet_terapist_controller.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/empty.dart';

import '../../../widget/app_bar_home.dart';

class WalletPageTherapist extends StatelessWidget {
  WalletPageTherapist({super.key});
  final UserController userController = Get.find();
  final WalletTerapistController controller =
      Get.put(WalletTerapistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Obx(() {
            return Column(
              children: [
                AppBarHome(
                    name:
                        "${userController.user.value.firstName ?? ''} ${userController.user.value.lastName ?? ''}",
                    image:
                        userController.user.value.therapist?.photo?.url ?? ''),
                totalBalance(),
                24.0.height,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    AppImage.bannerHomeUser,
                    height: 156.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                24.0.height,
                earning(context),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget earning(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColor.strokeColor,
            width: 2.w,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Earning',
                  style: AppFont.semibold16,
                ),
                Image.asset(
                  AppIcon.more,
                  width: 24.w,
                ),
              ],
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () => controller.getHistoryPayment(),
              child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    )
                  : controller.listPayment.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: const Empty(
                              title: "No Data",
                              width: 180,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, indext) => itemEarning(
                              context: context,
                              payment: controller.listPayment[indext]),
                          itemCount: controller.listPayment.length,
                        ),
            ))
          ],
        ),
      ),
    );
  }

  Widget itemEarning(
      {required HistoryPaymentTherapist payment,
      required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 16.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.36,
                child: Text(
                  payment.toAccount ?? '',
                  style: AppFont.medium14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.38,
                child: Text(
                  payment.serviceName ?? '',
                  style: AppFont.medium14,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          8.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.36,
                child: Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(payment.paymentAt ?? DateTime.now()),
                  style: AppFont.reguler12.copyWith(
                    color: AppColor.textSoft,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.38,
                child: Text(
                  payment.senderAccount ?? '',
                  style: AppFont.reguler12.copyWith(
                    color: AppColor.textSoft,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          8.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.h,
                ),
                width: 60.w,
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColor.primaryColor.withOpacity(0.1),
                ),
                child: Image.asset(
                  WidgetHelper.paymentImage(payment.paymentMethod ?? ''),
                  width: 32.w,
                ),
              ),
              Text(
                NumberFormat.currency(
                  symbol: 'Rp ',
                  decimalDigits: 2,
                  locale: 'id_ID',
                ).format(payment.amountPaid),
                style: AppFont.medium14,
              ),
            ],
          ),
          16.0.height,
          Divider(
            color: AppColor.textSoft.withOpacity(0.5),
            height: 2.h,
          ),
        ],
      ),
    );
  }

  Widget totalBalance() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AppImage.cardWallet,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: AppFont.reguler14,
          ),
          8.0.height,
          Text(
            NumberFormat.currency(
              symbol: 'Rp ',
              decimalDigits: 2,
              locale: 'id_ID',
            ).format(userController.user.value.balance ?? 0),
            style: AppFont.medium24,
          ),
          22.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${userController.user.value.firstName} ${userController.user.value.lastName}',
                style: AppFont.reguler12,
              ),
              Text(
                'My Wallet',
                style: AppFont.reguler12,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget headerWallet() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              AppImage.getStarted,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          12.0.width,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
              ),
              Text('Ahmad Saiful', style: AppFont.semibold16)
            ],
          )),
          12.0.width,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcon.notifIcon,
                  width: 24.w,
                ),
              ),
              12.0.width,
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  AppIcon.loveIcon,
                  width: 24.w,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
