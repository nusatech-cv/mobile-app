import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class SecondaryButtonV2 extends StatelessWidget {
  const SecondaryButtonV2({
    super.key,
    required this.title,
    this.height = 52,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.disable = false,
    this.icon,
    this.loading = false,
  });

  final String title;
  final double width;
  final EdgeInsets margin;
  final double height;
  final Function() onPressed;
  final bool disable;
  final bool loading;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                disable ? Theme.of(context).canvasColor : AppColor.strokeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        onPressed: disable || loading ? () {} : onPressed,
        child: loading
            ? SizedBox(
                height: 24.h,
                width: 24.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  Text(
                    title,
                    style: AppFont.medium14.copyWith(
                        color: disable
                            ? Theme.of(context).disabledColor
                            : AppColor.textSoft),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
