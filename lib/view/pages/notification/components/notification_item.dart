import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/notification/notification_model.dart';
import 'package:pijetin/utils/extension/double_extension.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notificationModel;
  final void Function()? onTap;
  const NotificationItem({
    super.key,
    required this.notificationModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            color: notificationModel.isRead == null
                ? AppColor.background
                : AppColor.primaryColor.withOpacity(0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  AppIcon.notifItem,
                  height: 24.w,
                  width: 24.w,
                ),
                8.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationModel.messages ?? '',
                        // DateFormat('dd').format(
                        //   notificationModel.createdAt ?? DateTime.now(),
                        // ),
                        style: AppFont.medium12,
                      ),
                      Text(
                        DateFormat('d-MM-yyyy HH:mm').format(
                          notificationModel.createdAt!.toLocal(),
                        ),
                        style:
                            AppFont.medium10.copyWith(color: AppColor.textSoft),
                      ),
                    ],
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
