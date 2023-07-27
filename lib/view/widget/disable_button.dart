import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class DisabledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Function()? onpressed;
  final EdgeInsets margin;
  final Color color;
  const DisabledButton({
    Key? key,
    required this.title,
    this.onpressed,
    this.height = 54,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.color = AppColor.disableColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        onPressed: onpressed,
        child: Text(title,
            style: AppFont.medium14.copyWith(color: AppColor.textLight)),
      ),
    );
  }
}
