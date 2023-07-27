import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/data/model/user/service/service.dart';

import '../../config/config.dart';

class TabBarCategory extends StatelessWidget {
  final Service? selectedCategory;
  final List<Service> category;
  final Function(Service)? onTap;
  final double fonsize;
  final bool centerTab;
  const TabBarCategory({
    Key? key,
    this.selectedCategory,
    required this.category,
    this.onTap,
    required this.fonsize,
    required this.centerTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          centerTab ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: category
          .map((e) => Padding(
                padding: EdgeInsets.only(right: 4.w, left: 4.w),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(e);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 1,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                width: 1.h, color: AppColor.primaryColor),
                            color: e == selectedCategory
                                ? AppColor.primaryColor
                                : Colors.transparent),
                        child: Text(
                          e.name ?? '',
                          style: AppFont.medium14.copyWith(
                            color: e == selectedCategory
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
