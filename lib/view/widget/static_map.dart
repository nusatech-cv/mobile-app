import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

import '../../data/data.dart';

class CommonStaticMap extends StatelessWidget {
  const CommonStaticMap({super.key, required this.centerLocation, this.ontap});
  final Location centerLocation;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 176.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: StaticMap(
          googleApiKey: Environment.getApiKey() ?? '',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          scaleToDevicePixelRatio: true,
          zoom: 14,
          center: centerLocation,
          markers: <Marker>[
            Marker(
              color: Colors.red,
              size: MarkerSize.mid,
              locations: [centerLocation],
            ),
          ],
        ),
      ),
    );
  }
}
