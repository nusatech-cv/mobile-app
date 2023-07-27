import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/model/user/service/service.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_controller.dart';
import 'package:pijetin/domain/repository/repository.dart';

import '../websocket_controller.dart';

class HomeUserController extends GetxController {
  var isLoadingServices = false.obs;

  var serviceList = <Service>[].obs;

  late TherapistController therapistController;

  @override
  void onInit() {
    Websocket.instance.onInit();
    therapistController = Get.put(TherapistController());
    init();

    super.onInit();
  }

  init() {
    subscribeNotification();
    getServices();
  }

  Future<void> getServices() async {
    isLoadingServices.value = true;
    ServiceRepository serviceRepository = ServiceRepository();
    final response = await serviceRepository.getServices();
    serviceList.assignAll(response);
    isLoadingServices.value = false;
  }

  subscribeNotification() async {
    UserRepository userRepository = UserRepository();
    var token = await FirebaseMessaging.instance.getToken();
    await userRepository.subscribeNotififcation(token ?? "");
  }

  refreshPage() {
    serviceList.clear();
    getServices();
    therapistController.onInit();
  }
}
