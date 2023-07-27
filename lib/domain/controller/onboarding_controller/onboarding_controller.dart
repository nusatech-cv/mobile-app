import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/view/pages/auth/GoogleSignIn/google_sign_in_page.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void changePage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    } else {
      Get.off(() => GoogleSignInPage());
      GetStorage().write('seenOnBoarding', true);
    }
  }
}
