import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/domain/controller/location_controller.dart';

class RequestHeaders {
  final LocationController locationController = Get.find();

  Map<String, String> setAuthHeaders() {
    String token = GetStorage().read('token') ?? "";
    return {
      "Authorization": "Bearer $token",
      'Accept': "application/json",
      'Content-Type': 'application/json',
      'x-user-location': jsonEncode({
        "x": locationController.currentLocation.value.latitude,
        "y": locationController.currentLocation.value.longitude
      })
    };
  }
}
