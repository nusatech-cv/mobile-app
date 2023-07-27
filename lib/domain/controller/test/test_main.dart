import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/theme/style.dart';

class TestMain extends StatelessWidget {
  final Widget? child;
  const TestMain({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, childx) {
          return Builder(builder: (context) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Home Spa',
              theme: Styles.themeData(false, context),
              home: child,
            
            );
          });
        });
  }
}
