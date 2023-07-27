import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/controller.dart';
import 'package:pijetin/utils/extension/extension.dart';
import 'package:pijetin/view/widget/input_text.dart';

class MyProfileUserPage extends StatelessWidget {
  MyProfileUserPage({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              header(),
              24.0.height,
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: 124.w,
                      height: 124.w,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  NetworkImage(controller.user.value.avatar!))),
                    ),
                    16.0.height,
                    InputText(
                      enable: false,
                      title: 'First Name',
                      hintText: controller.user.value.firstName!,
                    ),
                    8.0.height,
                    InputText(
                      enable: false,
                      title: 'Last Name',
                      hintText: controller.user.value.lastName!,
                    ),
                    8.0.height,
                    InputText(
                      enable: false,
                      title: 'Role',
                      hintText: controller.user.value.role!,
                    ),
                    8.0.height,
                    InputText(
                      enable: false,
                      title: 'Email',
                      hintText: controller.user.value.email!,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        12.0.width,
        Text(
          'My Profile',
          style: AppFont.medium16,
        ),
      ],
    );
  }
}
