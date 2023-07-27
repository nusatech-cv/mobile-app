import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/utils/extension/double_extension.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../config/theme/theme.dart';

Future<dynamic> selectImageBottomSheet(
  BuildContext context, {
  void Function(XFile?)? onPick,
}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: ScreenUtil().screenHeight * 0.35,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Photo Profile",
                style: AppFont.semibold16.copyWith(
                  color: AppColor.textStrong,
                ),
              ),
              12.0.height,
              Expanded(
                child: Column(
                  children: [
                    32.0.height,
                    itemSelect(
                      icon: Image.asset(
                        AppIcon.selectCamera,
                        width: 54.w,
                      ),
                      title: "Take a Photo",
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {
                          onPick!(image);
                        }
                        Get.back();
                      },
                    ),
                    24.0.height,
                    itemSelect(
                      icon: Image.asset(
                        AppIcon.selectGallery,
                        width: 54.w,
                      ),
                      title: "Select from gallery",
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          onPick!(image);
                        }
                        Get.back();
                      },
                    ),
                    16.0.height,
                    SecondaryButtonV2(
                      title: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget itemSelect({String? title, Widget? icon, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon ?? const SizedBox(),
        8.0.width,
        Text(
          title ?? "",
          style: AppFont.medium16.copyWith(
            color: AppColor.textSoft,
          ),
        )
      ],
    ),
  );
}
