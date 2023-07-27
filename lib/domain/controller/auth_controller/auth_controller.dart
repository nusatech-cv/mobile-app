import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pijetin/data/model/user/user/user_data.dart';
import 'package:pijetin/view/pages/auth/GoogleSignIn/google_sign_in_page.dart';
import 'package:pijetin/view/pages/terapist/main_page_terapist.dart';
import 'package:pijetin/view/pages/user/main_page_user.dart';
import '../../../utils/helper/custom_snackbar.dart';
import '../../../view/pages/auth/GoogleSignIn/choose_role_page.dart';
import '../../../view/pages/auth/TherapistFormData/form_therapist_page.dart';
import '../../repository/repository.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = UserData().obs;
  var isUpdateLoading = false.obs;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<void> signInWithGoogle() async {
    final AuthRepository authRepository = AuthRepository();
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final String? accessToken = googleAuth.accessToken;
      log("Access token : $accessToken");
      log(accessToken.toString());
      if (accessToken != null) {
        var response = await authRepository.signIn(accessToken);
        log(response.body.toString());
        if (response.statusCode == 201 || response.statusCode == 200) {
          log("RESSSSS : ${response.statusCode}");
          log("RESSSSS : ${response.body}");
          String token = jsonDecode(response.body!)['token'];
          GetStorage().write('token', token);
          user.value = userDataFromJson(response.body!);
          if (user.value.role == 'User') {
            Get.offAll(() => MainPageUser());
          } else if (user.value.role == 'Therapist') {
            Get.offAll(() => MainPageTerapist());
          } else {
            Get.off(() => ChooseRolePage());
          }
        } else {
          errorSnackbar("Error", jsonDecode(response.body!)['message']);
        }
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }

  Future<void> logoutWithGoogle() async {
    try {
      GetStorage().remove('token');
      final GoogleSignInAccount? googleUser = await googleSignIn.signOut();
      Get.offAll(() => GoogleSignInPage());
      log("logout =$googleUser");
    } catch (error) {
      log('Google Sign-In error: $error');
    }
  }

  Future<void> updateRole(String role) async {
    final AuthRepository authRepository = AuthRepository();
    try {
      isUpdateLoading.value = true;
      var response = await authRepository.updateRole(role);
      log(response.body.toString());
      if (response.statusCode == 201) {
        if (role == "User") {
          Get.off(() => MainPageUser());
        } else {
          Get.to(() => FormTherapistPage());
        }
      }
      isUpdateLoading.value = false;
    } catch (e) {
      isUpdateLoading.value = false;
      throw Exception(e.toString());
    }
  }
}
