import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/data/src/src.dart';
import 'package:pijetin/utils/extension/extension.dart';

import '../../config/config.dart';

class CustomTabBar extends StatelessWidget {
  final int? selectedIndex;
  final List<String> titles;
  final Function(int)? onTap;
  final double fonsize;
  final bool centerTab;
  final bool isRating;
  const CustomTabBar({
    Key? key,
    required this.titles,
    this.centerTab = false,
    this.isRating = false,
    this.selectedIndex,
    this.fonsize = 14,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          centerTab ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: titles
          .map((e) => Padding(
                padding: EdgeInsets.only(
                    right: e == titles.last ? 24.w : 8.w,
                    left: e == titles.first ? 24.w : 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(titles.indexOf(e));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                width: 1.h, color: AppColor.primaryColor),
                            color: titles.indexOf(e) == selectedIndex
                                ? AppColor.primaryColor
                                : Colors.transparent),
                        child: isRating
                            ? Row(
                                children: [
                                  Image.asset(
                                    AppIcon.starIcon,
                                    width: 16.w,
                                    color: titles.indexOf(e) == selectedIndex
                                        ? AppColor.background
                                        : AppColor.primaryColor,
                                  ),
                                  8.0.width,
                                  Text(
                                    e,
                                    style: AppFont.medium14.copyWith(
                                      color: titles.indexOf(e) == selectedIndex
                                          ? AppColor.background
                                          : AppColor.primaryColor,
                                      fontSize: fonsize.sp,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                e,
                                style: AppFont.medium14.copyWith(
                                  color: titles.indexOf(e) == selectedIndex
                                      ? AppColor.background
                                      : AppColor.primaryColor,
                                  fontSize: fonsize.sp,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
