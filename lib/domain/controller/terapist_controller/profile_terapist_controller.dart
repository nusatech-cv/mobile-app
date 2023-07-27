import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/model/user/user/user_data.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';

class ProfileTherapistController extends GetxController {
  UserController homeController = Get.find();
  var user = UserData().obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final roleController = TextEditingController();
  final emailController = TextEditingController();
  final experienceController = TextEditingController();
  final workDayController = TextEditingController();
  final workTimeController = TextEditingController();

  @override
  void onInit() {
    user.value = homeController.user.value;
    super.onInit();
  }
}
