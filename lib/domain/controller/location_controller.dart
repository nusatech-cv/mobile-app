import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class LocationController extends GetxController {
  var currentLocation = const Location(
    34.016839,
    -118.488240,
  ).obs;

  var isLoadingLocation = false.obs;

  var selectedLocationStreet = "".obs;
  var selectedLocationSubLocality = "".obs;
  var selectedLocationLocality = "".obs;
  var selectedLocationAdministrativeArea = "".obs;
  var selectedLocationSubAdministrativeArea = "".obs;
  var selectedLocationPostalCode = "".obs;
  var address = ''.obs;
  var pickerLocation = const LatLng(0, 0).obs;
  var authToken = "".obs;

  @override
  void onInit() async {
    getCurrentLocation();
    super.onInit();
  }

  Future getCurrentLocation() async {
    var permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}

    if (permission == LocationPermission.deniedForever) {}
    log("Permision location => ${permission.toString()}");
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      log("Position location => ${position.toString()}");
      currentLocation.value = Location(position.latitude, position.longitude);
      await pickLocation(LatLng(position.latitude, position.longitude));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future pickLocation(LatLng point) async {
    isLoadingLocation.value = true;
    pickerLocation.value = point;
    pickerLocation.refresh();
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          pickerLocation.value.latitude, pickerLocation.value.longitude);
      if (placemarks.isNotEmpty) {
        geo.Placemark placemark = placemarks[0];
        log(placemark.toJson().toString());

        selectedLocationStreet.value = placemark.name ?? "";
        selectedLocationSubLocality.value = placemark.subLocality ?? "";
        selectedLocationLocality.value = placemark.locality ?? "";
        selectedLocationAdministrativeArea.value =
            placemark.administrativeArea ?? "";
        selectedLocationSubAdministrativeArea.value =
            placemark.subAdministrativeArea ?? "";
        selectedLocationPostalCode.value = placemark.postalCode ?? "";
        address.value =
            '${selectedLocationSubLocality.value}, ${selectedLocationLocality.value} ${selectedLocationAdministrativeArea.value}, ${selectedLocationSubAdministrativeArea.value} ${selectedLocationPostalCode.value}';

        return pickerLocation.value;
      }
      return pickerLocation.value;
    } catch (e) {
      log(e.toString());
      isLoadingLocation.value = false;
    }

    isLoadingLocation.value = false;
  }

  Future<String> dacodeLocation(LatLng point) async {
    isLoadingLocation.value = true;
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(point.latitude, point.longitude);
    if (placemarks.isNotEmpty) {
      geo.Placemark placemark = placemarks[0];
      log(placemark.toJson().toString());
      return '${selectedLocationSubLocality.value}, ${selectedLocationLocality.value} ${selectedLocationAdministrativeArea.value}, ${selectedLocationSubAdministrativeArea.value} ${selectedLocationPostalCode.value}';
    } else {
      return '';
    }
  }

  getAuthToken() async {
    final token = GetStorage().read('token') ?? "";
    authToken.value = token;
  }
}
