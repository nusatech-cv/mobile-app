import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/utils/utils.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, this.rate = 0, this.size = 16});
  final double rate;
  final double size;
  @override
  Widget build(BuildContext context) {
    Widget star(int value) {
      return rate < value
          ? Image.asset(
              AppIcon.starOutlineIcon,
              width: size.w,
            )
          : Image.asset(
              AppIcon.starIcon,
              width: size.w,
              color: AppColor.yellowColor,
            );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        star(1),
        8.0.width,
        star(2),
        8.0.width,
        star(3),
        8.0.width,
        star(4),
        8.0.width,
        star(5),
      ],
    );
  }
}
