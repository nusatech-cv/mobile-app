import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/terapist_controller/history_terapist_controller.dart';
import 'package:pijetin/view/widget/empty.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../DetailBookingTerapist/detail_booking_terapist.dart';

class AllHistoryTerapist extends StatelessWidget {
  AllHistoryTerapist({super.key});
  final HistoryOrderTerapistController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.listOrderHistory.isEmpty
          ? const Center(
              child: Empty(
              title: "No data",
              subtitle: "There’s no data in this appointment yet",
            ))
          : ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(() => DetailBookingTerapist(
                        id: controller.listOrderHistory.toList()[index].id!,
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: CardBooking(
                    order: controller.listOrderHistory[index],
                  ),
                ),
              ),
              itemCount: controller.listOrderHistory.length,
            );
    });
  }
}
