import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/utils/extension/extension.dart';

import '../../config/config.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.height = 52,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.icon,
    this.borderColor = AppColor.primaryColor,
    this.textColor = AppColor.primaryColor,
    this.backgroundColor,
    this.fontSize = 16,
    this.isloading = false,
    required this.onPressed,
  });

  final String title;
  final double width;
  final double fontSize;
  final EdgeInsets margin;
  final double height;
  final Widget? icon;
  final Color borderColor;
  final Color textColor;
  final bool isloading;
  final Color? backgroundColor;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(width: 1.h, color: borderColor),
            backgroundColor:
                backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            // const Color(0xffD2F1FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        onPressed: isloading == true ? () {} : onPressed,
        child: isloading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.textSoft,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  icon != null ? 8.0.width : 0.0.width,
                  Text(
                    title,
                    style: AppFont.medium16
                        .copyWith(color: textColor, fontSize: fontSize.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
