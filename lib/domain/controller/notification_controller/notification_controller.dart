import 'dart:developer';

import 'package:get/get.dart';
import 'package:pijetin/data/model/user/notification/notification_model.dart';
import 'package:pijetin/domain/repository/notification_repository/notification_repository.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var listNotif = <NotificationModel>[].obs;

  @override
  void onInit() {
    getListNotification();
    super.onInit();
  }

  Future<void> getListNotification({bool isReload = true}) async {
    if (isReload) {
      isLoading.value = true;
    }

    NotificationRepository notificationRepository = NotificationRepository();
    final response = await notificationRepository.getListNotification();

    if (response != null) {
      log("NOTIF ${response.length}");
      listNotif.assignAll(response);
    }

    if (isReload) {
      isLoading.value = false;
    }

    listNotif.refresh();
  }

  Future<void> readNotification(int notifId) async {
    NotificationRepository notificationRepository = NotificationRepository();
     await notificationRepository.readNotification(notifId);
    // if (response) {
    await getListNotification(isReload: false);
    // }
  }
}
