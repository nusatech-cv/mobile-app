import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/utils/utils.dart';

import '../../config/config.dart';

class WidgetHelper {
  static appBar({
    Function()? onTap,
    required String title,
    Widget? leading,
    bool isWithFavorite = false,
  }) {
    return AppBar(
      elevation: 0.5.h,
      title: Row(
        children: [
          8.0.width,
          GestureDetector(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColor.textStrong,
              size: 24.w,
            ),
          ),
          13.0.width,
          Expanded(
            child: Text(title, style: AppFont.medium16),
          ),
          13.0.width,
          leading ??
              (isWithFavorite
                  ? Image.asset(
                      AppIcon.loveIcon,
                      width: 24.w,
                    )
                  : const SizedBox()),
          8.0.width,
        ],
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.background,
    );
  }

  static String paymentImage(String? pay) {
    switch (pay) {
      case "OVO":
        return AppImage.paymentOvo;
      case "DANA":
        return AppImage.paymentDana;
      case "BIDR":
        return AppImage.paymentBidr;

      default:
        return AppImage.paymentOvo;
    }
  }

  static String day(int id) {
    switch (id) {
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";

      default:
        return "Sunday";
    }
  }
}

handleCopy({required String data}) async {
  await Clipboard.setData(ClipboardData(text: data)).then(
    (_) => Get.snackbar(
      'Success',
      'Address copied to clipboard',
      colorText: Colors.white,
      backgroundColor: AppColor.primaryColor,
    ),
  );
}
