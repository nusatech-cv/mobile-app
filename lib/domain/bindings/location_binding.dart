import 'package:get/get.dart';
import '../controller/location_controller.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.isRegistered<LocationController>()
        ? Get.find<LocationController>()
        : Get.put(LocationController());
  }
}
