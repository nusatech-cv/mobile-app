import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/domain/controller/location_controller.dart';
import 'package:pijetin/domain/repository/repository.dart';
import 'package:pijetin/utils/helper/custom_snackbar.dart';
import 'package:pijetin/view/pages/auth/TherapistFormData/form_therapist_category_page.dart';
import 'package:pijetin/data/model/user/service/service.dart';

import '../../../data/data.dart';

class TerapistAuthController extends GetxController {
  late LocationController locationController;
  var isPostLoading = false.obs;
  var isServiceLoading = false.obs;
  var isGetServiceLoading = false.obs;
  var listCategory = <Service>[].obs;
  var selectedCategory = <Service>[].obs;
  var finishDisable = true.obs;

  List<dynamic> days = [
    {"id": 0, "day": "Sunday"},
    {"id": 1, "day": "Monday"},
    {"id": 2, "day": "Tuesday"},
    {"id": 3, "day": "Wednesday"},
    {"id": 4, "day": "Thursday"},
    {"id": 5, "day": "Friday"},
    {"id": 6, "day": "Saturday"},
  ];
  List<String> genders = ["Male", "Female"];
  var pickerLocation = const LatLng(0, 0).obs;
  var addressPicker = ''.obs;
  var pickPictureLoading = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDayController = TextEditingController();
  final experienceController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  var profilPic = File("").obs;

  var selectedStartDay = 0.obs;
  var selectedEndDay = 0.obs;
  var selectedGender = ''.obs;
  var selectedStartTime = TimeOfDay.now().obs;
  var selectedEndTime = TimeOfDay.now().obs;
  var birthDay = DateTime.now().obs;
  var isValidatePersonal = true.obs;

  @override
  void onInit() async {
    locationController = Get.find();
    await locationController.getCurrentLocation();
    getServices();
    setDefault();
    super.onInit();
  }

  void validateFinish() {
    if (selectedCategory.isNotEmpty) {
      finishDisable.value = false;
    } else {
      finishDisable.value = true;
    }
  }

  void validatePersonalData() {
    if (profilPic.value.path != '' &&
        firstNameController.text != '' &&
        lastNameController.text != '' &&
        birthDayController.text != '' &&
        selectedGender.value != '' &&
        experienceController.text != '' &&
        startTimeController.text != '' &&
        endTimeController.text != '') {
      isValidatePersonal.value = false;
    } else {
      isValidatePersonal.value = true;
    }
  }

  setDefault() {
    pickerLocation.value = LatLng(
        locationController.currentLocation.value.latitude,
        locationController.currentLocation.value.longitude);
    addressPicker.value = locationController.address.value;
  }

  changeProfilPic(XFile xfile) async {
    pickPictureLoading.value = true;
    File file = File(xfile.path);
    profilPic.value = file;
    profilPic.refresh();
    validatePersonalData();
    pickPictureLoading.value = false;
  }

  setCategory(Service value) {
    selectedCategory.add(value);
    validateFinish();
  }

  deleteCategory(Service value) {
    selectedCategory.removeWhere(
      (element) => element == value,
    );
    validateFinish();
  }

  Future<void> postServiceTerapist(Service value) async {
    AuthRepository authRepository = AuthRepository();
    try {
      isServiceLoading.value = true;

      log(value.serviceId.toString());
      var response = await authRepository.postServiceTerapist(value.serviceId!);

      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        setCategory(value);
      }

      isServiceLoading.value = false;
    } catch (e) {
      isServiceLoading.value = false;
      throw Exception(e);
    }
  }

  Future<void> deleteService(Service value) async {
    AuthRepository authRepository = AuthRepository();
    try {
      isServiceLoading.value = true;

      log(value.serviceId.toString());
      var response = await authRepository.deleteService(value.serviceId!);

      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        deleteCategory(value);
      }

      isServiceLoading.value = false;
    } catch (e) {
      isServiceLoading.value = false;
      throw Exception(e);
    }
  }

  void setStartDay(int value) => selectedStartDay.value = value;
  void setEndDay(int value) => selectedEndDay.value = value;

  void setGender(String value) {
    selectedGender.value = value;
    validatePersonalData();
  }

  void setStartTime(TimeOfDay value, BuildContext context) {
    if (endTimeController.text != '') {
      if (selectedEndTime.value.hour > value.hour &&
          selectedEndTime.value.hour - value.hour > 1) {
        selectedStartTime.value = value;
        startTimeController.text = selectedStartTime.value.format(context);
      } else {
        errorSnackbar("Warning", "End time must higher than start time");
      }
    } else {
      selectedStartTime.value = value;
      startTimeController.text = selectedStartTime.value.format(context);
    }

    validatePersonalData();
  }

  void setEndTime(TimeOfDay value, BuildContext context) {
    if (value.hour > selectedStartTime.value.hour &&
        value.hour - selectedStartTime.value.hour > 1) {
      selectedEndTime.value = value;
      endTimeController.text = selectedEndTime.value.format(context);
    } else {
      errorSnackbar("Warning", "End time must higher than start time");
    }
    validatePersonalData();
  }

  void setBirthDay(DateTime value) {
    birthDay.value = value;
    birthDayController.text = DateFormat("dd MMMM yyyy").format(birthDay.value);
    validatePersonalData();
  }

  void setLocation(LatLng value) async {
    pickerLocation.value = value;
    addressPicker.value = await locationController.dacodeLocation(value);
    log(pickerLocation.value.toString());
  }

  void postTerapist(BuildContext context) async {
    AuthRepository userRepository = AuthRepository();
    var location = jsonEncode({
      "x": pickerLocation.value.latitude,
      "y": pickerLocation.value.longitude
    });
    log(location);
    try {
      isPostLoading.value = true;
      final String baseUrl = Environment.getApiBaseUrl();
      final String appVersion = Environment.getApiAppVersion()!;
      var url = '$baseUrl${appVersion}users/therapists';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['first_name'] = firstNameController.text;
      request.fields['last_name'] = lastNameController.text;
      request.fields['location'] = location;
      request.fields['experience_years'] = experienceController.text;
      request.fields['gender'] = selectedGender.value.toUpperCase();
      request.fields['is_available'] = true.toString();
      request.fields['birthdate'] =
          DateFormat("yyyy-MM-dd").format(birthDay.value);
      request.fields['day_start'] = selectedStartDay.value.toString();
      request.fields['day_end'] = selectedEndDay.value.toString();
      request.fields['working_start'] = startTimeController.text;
      request.fields['working_end'] = endTimeController.text;
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('photo', profilPic.value.path);
      request.files.add(multipartFile);

      var response = await userRepository.postTherapist(request);

      log("status => ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.to(() => FormTherapistCategoryPage());
        isPostLoading.value = false;
      } else {
        errorSnackbar('fail', response.body.toString());

        isPostLoading.value = false;
      }

      isPostLoading.value = false;
    } catch (error) {
      errorSnackbar('fail', error.toString());
      isPostLoading.value = false;
    }
  }

  Future<void> getServices() async {
    isGetServiceLoading.value = true;

    ServiceRepository serviceRepository = ServiceRepository();
    final response = await serviceRepository.getServices();
    listCategory.value = response;

    isGetServiceLoading.value = false;
  }

  void onFirstNameChange(String value) {
    validatePersonalData();
  }

  void onLastNameChange(String value) {
    validatePersonalData();
  }

  void experienceChange(String value) {
    validatePersonalData();
  }
}
