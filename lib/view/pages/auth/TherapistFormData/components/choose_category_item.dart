import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/model/user/service/service.dart';
import 'package:pijetin/domain/controller/auth_controller/terapist_auth_controller.dart';

class ChooseCategoryItem extends StatelessWidget {
  final Service category;

  final Function(bool)? onChanged;
  ChooseCategoryItem({
    super.key,
    required this.category,
    this.onChanged,
  });
  final TerapistAuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.strokeColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.name ?? '',
            style: AppFont.reguler14.copyWith(
              color: AppColor.textSoft,
            ),
          ),
          Obx(() {
            return CupertinoSwitch(
              activeColor: AppColor.primaryColor,
              value: controller.selectedCategory
                  .any((element) => element == category),
              onChanged: onChanged,
            );
          }),
        ],
      ),
    );
  }
}
