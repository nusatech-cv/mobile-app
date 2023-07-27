import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/app_color.dart';



void successSnackbar(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: AppColor.greenColor, colorText: Colors.white);
}

void errorSnackbar(String error, String message) {
  Get.snackbar(error, message,
      backgroundColor: AppColor.errorColor, colorText: Colors.white);
}
