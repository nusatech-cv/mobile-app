import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/activity/activity_histories.dart';
import 'package:pijetin/utils/extension/double_extension.dart';

class ActivityItem extends StatelessWidget {
  final ActivityHistories activityHistories;
  const ActivityItem({super.key, required this.activityHistories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Log Activity',
                style: AppFont.semibold16,
              ),
              Image.asset(
                AppIcon.info,
                width: 20.w,
              ),
            ],
          ),
          18.0.height,
          activityData(
            title: 'First Name :',
            value: activityHistories.firstName ?? '',
          ),
          activityData(
            title: 'Last Name :',
            value: activityHistories.lastName ?? '',
          ),
          activityData(
            title: 'Email :',
            value: activityHistories.result ?? '',
          ),
          activityData(
            title: 'IP Address :',
            value: activityHistories.ipAddress ?? '',
          ),
          activityData(
            title: 'Action :',
            value: activityHistories.activityType ?? '',
          ),
          activityData(
            title: 'Device Info :',
            value: activityHistories.deviceInfo ?? '',
          ),
          activityData(
              title: 'Status : ',
              value: activityHistories.result ?? '',
              color: activityHistories.result == "success"
                  ? AppColor.greenColor
                  : AppColor.errorColor),
          activityData(
            title: 'Date : ',
            value: DateFormat('dd MMMM yyyy HH:mm').format(
              (activityHistories.createdAt ?? DateTime.now()).toLocal(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget activityData(
    {required String title,
    required String value,
    Color color = AppColor.textStrong}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFont.medium14.copyWith(
            color: AppColor.textSoft,
          ),
        ),
        Expanded(
          child: Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: AppFont.medium14.copyWith(color: color)),
        ),
      ],
    ),
  );
}
