import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/auth_controller/auth_controller.dart';
import 'package:pijetin/domain/controller/auth_controller/terapist_auth_controller.dart';
import 'package:pijetin/utils/extension/double_extension.dart';
import 'package:pijetin/view/pages/auth/TherapistFormData/components/choose_category_item.dart';
import 'package:pijetin/view/pages/terapist/main_page_terapist.dart';
import 'package:pijetin/view/widget/empty.dart';
import 'package:pijetin/view/widget/widget.dart';

class FormTherapistCategoryPage extends StatelessWidget {
  FormTherapistCategoryPage({super.key});
  final AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find()
      : Get.put(AuthController());
  final TerapistAuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.height,
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      color: AppColor.primaryColor,
                    ),
                    Text(
                      'Back',
                      style: AppFont.semibold14.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              24.0.height,
              Text(
                'Select Categories',
                style: AppFont.semibold16,
              ),
              8.0.height,
              Text(
                'Please choose your category data carefully.',
                style: AppFont.reguler14.copyWith(
                  color: AppColor.textSoft,
                ),
              ),
              16.0.height,
              Expanded(
                child: controller.isGetServiceLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.listCategory.isEmpty
                        ? const Center(
                            child: Empty(
                            title: "No Category Found",
                            subtitle: "Perhaps server is under maintenance",
                            width: 200,
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.listCategory.toList().length,
                            itemBuilder: (context, index) {
                              return ChooseCategoryItem(
                                onChanged: (value) {
                                  if (controller.selectedCategory.any(
                                      (element) =>
                                          element ==
                                          controller.listCategory[index])) {
                                    controller.deleteService(
                                        controller.listCategory[index]);
                                  } else {
                                    controller.postServiceTerapist(controller
                                        .listCategory
                                        .toList()[index]);
                                  }
                                },
                                category:
                                    controller.listCategory.toList()[index],
                              );
                            },
                          ),
              ),
              16.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.background,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: AppColor.primaryColor.withOpacity(0.15),
            )
          ],
        ),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                disable: controller.finishDisable.value,
                title: "Finish",
                onPressed: () {
                  Get.offAll(() => MainPageTerapist());
                },
                margin: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
              ),
              8.0.height,
              SecondaryButton(
                backgroundColor: AppColor.strokeColor,
                borderColor: AppColor.background,
                title: 'Cancel',
                textColor: AppColor.textSoft,
                onPressed: () {
                  Get.back();
                },
                margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
              ),
            ],
          );
        }),
      ),
    );
  }
}
