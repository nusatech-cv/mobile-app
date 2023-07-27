import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/model/user/user/user_data.dart';
import 'package:pijetin/domain/controller/location_controller.dart';
import 'package:pijetin/domain/repository/repository.dart';

class UserController extends GetxController {
  late final LocationController locationController;
  var isLoading = false.obs;
  var user = UserData().obs;
  var myLocation = "".obs;

  @override
  void onInit() async {
    locationController = Get.find();
    // getUser();
    getMyLocation();
    super.onInit();
  }

  Future<void> getUser() async {
    UserRepository userRepository = UserRepository();
    try {
      isLoading.value = true;

      final response = await userRepository.getProfile();
      user.value = userDataFromJson(response.body!);
      if (user.value.role == "Therapist") {
        final location = await placemarkFromCoordinates(
            user.value.therapist!.location!.y!,
            user.value.therapist!.location!.x!);

        user.value.address =
            "${location.first.subLocality}, ${location.first.locality}, ${location.first.subAdministrativeArea}, ${location.first.administrativeArea}, ${location.first.postalCode}";
      }

      user.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> getMyLocation() async {
    await locationController.getCurrentLocation();
    final location = await placemarkFromCoordinates(
        locationController.currentLocation.value.latitude,
        locationController.currentLocation.value.longitude);
    myLocation.value =
        "${location.first.subLocality}, ${location.first.locality}";
  }
}
