import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pijetin/utils/utils.dart';

import '../../config/config.dart';

class InputText extends StatelessWidget {
  final String? title;
  final String hintText;
  final bool obscureText;
  final bool strength;
  final Widget? icon;
  final Widget? prefixIcon;
  final Function()? ontaped;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLine;
  final Widget? crossTitle;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? enable;
  final Widget? suffix;
  final double width;
  final TextStyle? titleStyle;
  const InputText(
      {Key? key,
      this.obscureText = false,
      this.strength = false,
      this.title,
      required this.hintText,
      this.onChange,
      this.ontaped,
      this.textInputAction,
      this.icon,
      this.prefixIcon,
      this.maxLine = 1,
      this.width = double.infinity,
      this.crossTitle,
      this.validator,
      this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.focusNode,
      this.readOnly,
      this.suffix,
      this.enable,
      this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null && title != ''
              ? Column(
                  children: [
                    Text(
                      title ?? '',
                      style: titleStyle ?? AppFont.medium14,
                    ),
                    8.0.height,
                  ],
                )
              : const SizedBox(),
          TextFormField(
            focusNode: focusNode,
            onChanged: onChange,
            enabled: enable,
            readOnly: readOnly ?? false,
            validator: validator,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            onTap: ontaped,
            maxLines: maxLine,
            textAlignVertical: TextAlignVertical.center,
            style: AppFont.medium14
                .copyWith(color: Theme.of(context).indicatorColor),
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                suffixIcon: icon,
                prefixIcon: prefixIcon,
                suffix: suffix,
                hintText: hintText,
                hintStyle: AppFont.reguler14.copyWith(
                    fontWeight: FontWeight.w300, color: AppColor.textSoft),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColor.borderColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColor.borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h)),
          ),
        ],
      ),
    );
  }
}
