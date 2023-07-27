import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/view/pages/auth/GoogleSignIn/choose_role_page.dart';
import 'package:pijetin/view/pages/terapist/main_page_terapist.dart';
import 'dart:async';

import '../../../data/model/user/user/user_data.dart';
import '../../../view/pages/auth/GoogleSignIn/google_sign_in_page.dart';
import '../../../view/pages/auth/Onboarding/onboarding_page.dart';
import '../../../view/pages/user/main_page_user.dart';
import '../../bindings/location_binding.dart';
import '../../repository/repository.dart';

class SplashController extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    startTime();
    LocationBinding().dependencies();

    super.onInit();
  }

  startTime() async {
    return Timer(const Duration(milliseconds: 4000), isNewUser);
  }

  void checkUser() {
    String? token = GetStorage().read('token');
    if (token != null) {
      fetchUser();
    } else {
      Get.off(() => GoogleSignInPage());
    }
  }

  Future<void> fetchUser() async {
    final AuthRepository authRepository = AuthRepository();

    try {
      isLoading.value = true;
      var response = await authRepository.fetcUser();
      var data = userDataFromJson(response.body!);

      if (data.role == "User") {
        Get.off(() => MainPageUser());
      } else if (data.role == "Therapist") {
        Get.off(() => MainPageTerapist());
      } else {
        Get.off(() => ChooseRolePage());
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.off(() => GoogleSignInPage());
      // throw Exception(e);
    }
  }

  void isNewUser() {
    var seenOnBoarding = GetStorage().read('seenOnBoarding');
    seenOnBoarding = seenOnBoarding ?? false;
    if (seenOnBoarding) {
      checkUser();
    } else {
      Get.off(() => OnboardingPage());
    }
  }
}
