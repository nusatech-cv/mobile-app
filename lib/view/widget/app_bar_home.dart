import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/theme.dart';
import 'package:pijetin/data/src/src.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/notification/notification_page.dart';

class AppBarHome extends StatelessWidget {
  final String? name;
  final String? image;
  final void Function()? onTapNotification;
  final void Function()? onTapFavorite;

  const AppBarHome({
    this.name,
    this.image,
    this.onTapNotification,
    this.onTapFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              image: image != null
                  ? DecorationImage(
                      image: NetworkImage(image!), fit: BoxFit.cover)
                  : const DecorationImage(
                      image: AssetImage(AppImage.therapistPic)),
              shape: BoxShape.circle,
            ),
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning!",
                  style: AppFont.reguler14.copyWith(color: AppColor.textSoft),
                ),
                Text(
                  name ?? "",
                  style:
                      AppFont.semibold16.copyWith(color: AppColor.textStrong),
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.to(() => NotificationPage()),
            child: Image.asset(
              AppIcon.notifIcon,
              height: 24.w,
              width: 24.w,
            ),
          )
        ],
      ),
    );
  }
}
