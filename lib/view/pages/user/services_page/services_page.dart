import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/services_page/components/services_item.dart';
import 'package:pijetin/view/widget/empty.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  final TherapistController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.appBar(title: 'Services Categories'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.0.height,
            Text(
              "All Massage Service",
              style: AppFont.medium16,
            ),
            16.0.height,
            controller.isTabLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.messageList.isEmpty
                    ? const Center(
                        child: Empty(
                        title: "No Category Found",
                        subtitle: "Perhaps server is maintenance",
                        width: 200,
                      ))
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runSpacing: 10,
                        spacing: 19,
                        children: controller.messageList
                            .map((element) => SizedBox(
                                  width: 80.w,
                                  child: ServicesItem(
                                    name: element.name ?? "",
                                    icon: element.image == null
                                        ? null
                                        : element.image!.url,
                                  ),
                                ))
                            .toList(),
                      )
          ],
        ),
      ),
    );
  }
}
