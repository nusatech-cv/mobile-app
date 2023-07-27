import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/app_font.dart';
import 'package:pijetin/domain/controller/notification_controller/notification_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/notification/components/notification_item.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetHelper.appBar(title: "Notification"),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () => controller.getListNotification(),
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.listNotif.isEmpty
                    ? Center(
                        child: Text(
                          'No data found',
                          textAlign: TextAlign.center,
                          style: AppFont.reguler18,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.listNotif.toList().length,
                        itemBuilder: (context, index) {
                          return NotificationItem(
                            notificationModel:
                                controller.listNotif.toList()[index],
                            onTap: () {
                              // if (controller.listNotif[index].isRead != null &&
                              //     controller.listNotif[index].isRead! ==
                              //         false) {
                              controller.readNotification(controller.listNotif
                                  .toList()[index]
                                  .notifId!);
                              // }
                            },
                          );
                        },
                      ),
          ),
        ));
  }
}
