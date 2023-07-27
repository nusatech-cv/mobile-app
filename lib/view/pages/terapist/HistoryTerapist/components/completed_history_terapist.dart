import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../../../../domain/controller/terapist_controller/history_terapist_controller.dart';
import '../../../../widget/empty.dart';
import '../../DetailBookingTerapist/detail_booking_terapist.dart';

class CompletedHistoryTerapist extends StatelessWidget {
  CompletedHistoryTerapist({super.key});
  final HistoryOrderTerapistController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.listOrderHistory
              .where((element) => element.orderStatus == "done")
              .toList()
              .isEmpty
          ? const Center(
              child: Empty(
              title: "No data",
              subtitle: "There’s no data in this appointment yet",
            ))
          : ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(() => DetailBookingTerapist(
                        id: controller.listOrderHistory
                                .where(
                                    (element) => element.orderStatus == "done")
                                .toList()[index]
                                .id ??
                            0,
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: CardBooking(
                    order: controller.listOrderHistory
                        .where((element) => element.orderStatus == "done")
                        .toList()[index],
                  ),
                ),
              ),
              itemCount: controller.listOrderHistory
                  .where((element) => element.orderStatus == "done")
                  .toList()
                  .length,
            );
    });
  }
}
