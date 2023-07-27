import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/data/model/user/order_user/order_user.dart';
import 'package:pijetin/utils/utils.dart';
import '../../config/config.dart';

class CardBooking extends StatelessWidget {
  final Order? order;
  final void Function()? onTap;
  final String? role;
  const CardBooking({super.key, this.order, this.onTap, this.role});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1.h,
                  spreadRadius: 1.h,
                  color: AppColor.strokeColor)
            ],
            color: AppColor.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEE').format((order != null &&
                                      order!.appointmentDate != null)
                                  ? order!.appointmentDate!
                                  : DateTime.now()),
                              style: AppFont.medium12
                                  .copyWith(color: AppColor.textSoft),
                            ),
                            Text(
                                DateFormat('dd').format((order != null &&
                                        order!.appointmentDate != null)
                                    ? order!.appointmentDate!
                                    : DateTime.now()),
                                style: AppFont.semibold24),
                            Text(
                              DateFormat('MMM').format((order != null &&
                                      order!.appointmentDate != null)
                                  ? order!.appointmentDate!
                                  : DateTime.now()),
                              style: AppFont.medium12
                                  .copyWith(color: AppColor.primaryColor),
                            )
                          ],
                        ),
                      ),
                      8.0.width,
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order != null ? order!.serviceName! : "",
                            style: AppFont.semibold16,
                          ),
                          2.0.height,
                          Text(
                            'Massage between ${DateFormat('hh:mm a').format(order!.appointmentDate ?? DateTime.now())} - ${DateFormat('hh:mm a').format((order!.appointmentDate ?? DateTime.now()).add(Duration(minutes: order!.appointmentDuration ?? 0)))}',
                            style: AppFont.reguler14
                                .copyWith(color: AppColor.textSoft),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
            8.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                role == "User"
                    ? CircleAvatar(
                        maxRadius: 18.w,
                        backgroundColor: AppColor.primaryColor,
                        backgroundImage: order!.therapistAvatar!.url == null
                            ? null
                            : NetworkImage(order!.therapistAvatar!.url ?? ''),
                        child: order!.therapistAvatar!.url == null
                            ? Text(
                                "T",
                                style: AppFont.medium16
                                    .copyWith(color: Colors.white),
                              )
                            : null)
                    : CircleAvatar(
                        maxRadius: 18.w,
                        backgroundImage: NetworkImage(
                          order!.userAvatar!,
                          scale: 1,
                        ),
                      ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: order!.orderStatus == "done"
                          ? AppColor.greenColor.withOpacity(0.15)
                          : (order!.orderStatus == "cancel" ||
                                  order!.orderStatus == "expired")
                              ? AppColor.primaryColor.withOpacity(0.15)
                              : AppColor.yellowColor.withOpacity(0.15)),
                  child: Text(
                    (order!.orderStatus ?? '')
                            .replaceAll("_", " ")
                            .capitalize ??
                        '',
                    style: AppFont.semibold12.copyWith(
                        color: order!.orderStatus == "done"
                            ? AppColor.greenColor
                            : (order!.orderStatus == "cancel" ||
                                    order!.orderStatus == "expired")
                                ? AppColor.primaryColor
                                : AppColor.yellowColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
