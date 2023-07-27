import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../config/config.dart';
import '../../domain/controller/location_controller.dart';

class MapPicker extends StatelessWidget {
  MapPicker({super.key, this.point, this.ontap});
  final LocationController controller = Get.find();
  final LatLng? point;
  final Function(LatLng)? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: WidgetHelper.appBar(
          title: "Location",
          onTap: () {
            Get.back();
            controller.pickerLocation.value = const LatLng(0, 0);
          },
        ),
        body: Obx(() {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
                bearing: 0.0,
                target: point != null &&
                        (controller.pickerLocation.value.latitude == 0 ||
                            controller.pickerLocation.value.longitude == 0)
                    ? point!
                    : controller.pickerLocation.value,
                tilt: 0.0,
                zoom: 14),
            markers: {
              Marker(
                markerId: const MarkerId('me'),
                icon: BitmapDescriptor.defaultMarkerWithHue(10),
                position: point != null &&
                        (controller.pickerLocation.value.latitude == 0 ||
                            controller.pickerLocation.value.longitude == 0)
                    ? point!
                    : controller.pickerLocation.value,
              ),
            },
            onTap: (point) {
              controller.pickLocation(point);
            },
          );
        }),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(24.h),
            color: AppColor.background,
            child: PrimaryButton(
              key: const Key('pickLocation'),
                title: "Confirm",
                onPressed: () {
                  if (ontap != null) {
                    ontap!(controller.pickerLocation.value);
                  }
                  Get.back();
                })),
      ),
    );
  }
}
