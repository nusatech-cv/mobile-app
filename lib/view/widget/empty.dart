import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/utils/utils.dart';

import '../../config/config.dart';
import '../../data/data.dart';

class Empty extends StatelessWidget {
  const Empty(
      {super.key,
      required this.title,
      this.subtitle,
      this.style,
      this.width = 250});

  final String title;
  final String? subtitle;
  final TextStyle? style;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImage.ilustration2, width: width.w),
          24.0.height,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppFont.medium16,
          ),
          8.0.height,
          subtitle != null
              ? Text(
                  subtitle!,
                  style: AppFont.reguler12.copyWith(color: AppColor.textSoft),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
