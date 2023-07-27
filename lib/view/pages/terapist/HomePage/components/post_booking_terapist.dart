import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:pijetin/view/pages/terapist/DetailBookingTerapist/detail_booking_terapist.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../../../../domain/controller/terapist_controller/home_terapist_controller.dart';
import '../../../../widget/empty.dart';

class PostBookingTerapist extends StatelessWidget {
  PostBookingTerapist({super.key});
  final HomeTerapistController controller = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.orderList
              .where((element) =>
                  element.orderStatus == "done" ||
                  element.orderStatus == "cancel" ||
                  element.orderStatus == "expired")
              .toList()
              .isEmpty
          ? const Center(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Empty(
                width: 200,
                title: "No data",
                subtitle: "There’s no data in this appointment yet",
              ),
            ))
          : Column(
              children: controller.orderList
                  .where((element) =>
                      element.orderStatus == "done" ||
                      element.orderStatus == "cancel" ||
                      element.orderStatus == "expired")
                  .toList()
                  .map((element) => GestureDetector(
                        onTap: () {
                          Get.to(() => DetailBookingTerapist(
                                id: element.id ?? 0,
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.w),
                          child: CardBooking(
                            role: userController.user.value.role,
                            order: element,
                          ),
                        ),
                      ))
                  .toList());
    });
  }
}
