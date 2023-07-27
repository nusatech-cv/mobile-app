import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/config/theme/theme.dart';
import 'package:pijetin/data/data.dart';

class ServicesItem extends StatelessWidget {
  final String name;
  final String? icon;
  const ServicesItem({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70.w,
          width: 70.w,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: AppColor.cardColor, shape: BoxShape.circle),
          child: icon == null
              ? Image.asset(AppIcon.aromaterapic)
              : Image.network(
                  icon!,
                  height: 32.w,
                  width: 32.w,
                ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFont.medium14.copyWith(color: AppColor.textStrong),
        )
      ],
    );
  }
}
