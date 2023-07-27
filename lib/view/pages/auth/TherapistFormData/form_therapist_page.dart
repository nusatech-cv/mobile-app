// ignore_for_file: library_prefixes

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
    as staticMap;
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/auth_controller/terapist_auth_controller.dart';
import 'package:pijetin/view/widget/widget.dart';

import '../../../../utils/utils.dart';
import '../../../widget/map_picker.dart';

class FormTherapistPage extends StatelessWidget {
  FormTherapistPage({super.key});
  final TerapistAuthController controller = Get.put(TerapistAuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.h,
              horizontal: 24.w,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.chevron_left,
                        color: AppColor.primaryColor,
                      ),
                      Text(
                        'Back',
                        style: AppFont.semibold14.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                    ),
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Insert Personal Data',
                        style: AppFont.semibold16,
                      ),
                      8.0.height,
                      Text(
                        'Please enter your personal data carefully.',
                        style: AppFont.reguler14.copyWith(
                          color: AppColor.textSoft,
                        ),
                      ),
                      24.0.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Photo',
                            style: AppFont.medium14,
                          ),
                          8.0.height,
                          Row(
                            children: [
                              controller.profilPic.value.path == ""
                                  ? CircleAvatar(
                                      maxRadius: 32.w,
                                      backgroundImage: const AssetImage(
                                        AppIcon.profilePicture,
                                      ),
                                    )
                                  : CircleAvatar(
                                      maxRadius: 32.w,
                                      backgroundImage:
                                          FileImage(controller.profilPic.value),
                                    ),
                              16.0.width,
                              Expanded(
                                child: SecondaryButton(
                                  backgroundColor: AppColor.strokeColor,
                                  borderColor: AppColor.background,
                                  title: 'insert photo',
                                  textColor: AppColor.textSoft,
                                  onPressed: () {
                                    selectImageBottomSheet(
                                      context,
                                      onPick: (file) {
                                        if (file != null) {
                                          controller.changeProfilPic(file);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      16.0.height,
                      InputText(
                        controller: controller.firstNameController,
                        title: 'First name',
                        hintText: 'insert first name',
                        onChange: controller.onFirstNameChange,
                      ),
                      16.0.height,
                      InputText(
                        controller: controller.lastNameController,
                        title: 'Last name',
                        hintText: 'insert last name',
                        onChange: controller.onLastNameChange,
                      ),
                      16.0.height,
                      InputText(
                        title: 'Birth date',
                        hintText: 'insert birth date',
                        controller: controller.birthDayController,
                        keyboardType: TextInputType.datetime,
                        ontaped: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: controller.birthDay.value,
                                  firstDate: DateTime(1000),
                                  lastDate: DateTime.now())
                              .then((value) => controller
                                  .setBirthDay(value ?? DateTime.now()));
                        },
                      ),
                      16.0.height,
                      Text(
                        "Gender",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.w),
                            borderSide:
                                const BorderSide(color: AppColor.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.w),
                            borderSide:
                                const BorderSide(color: AppColor.primaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        dropdownStyleData: DropdownStyleData(
                            elevation: 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColor.background)),
                        buttonStyleData: ButtonStyleData(
                            height: 54.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h)),
                        isExpanded: true,
                        hint: Text(
                          "Select Gender",
                          style: AppFont.light14.copyWith(
                            color: AppColor.textSoft,
                          ),
                        ),
                        items: controller.genders
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item.capitalize ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.setGender(value ?? '');
                        },
                      ),
                      16.0.height,
                      InputText(
                          title: 'Experience',
                          hintText: 'select experience',
                          controller: controller.experienceController,
                          keyboardType: TextInputType.number,
                          onChange: controller.experienceChange,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          icon: Padding(
                            padding: EdgeInsets.only(
                                right: 16.w, top: 16.h, bottom: 16.h),
                            child: Text(
                              'Years',
                              style: AppFont.light14
                                  .copyWith(color: AppColor.textSoft),
                            ),
                          )),
                      16.0.height,
                      Text(
                        "Work Time",
                        style: AppFont.medium14,
                      ),
                      8.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.43,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  borderSide: const BorderSide(
                                      color: AppColor.borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  borderSide: const BorderSide(
                                      color: AppColor.primaryColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                  elevation: 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColor.background)),
                              buttonStyleData: ButtonStyleData(
                                  height: 54.h,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h)),
                              isExpanded: true,
                              hint: Text(
                                "Start Day",
                                style: AppFont.light14.copyWith(
                                  color: AppColor.textSoft,
                                ),
                              ),
                              items: controller.days
                                  .map((item) => DropdownMenuItem<dynamic>(
                                        value: item,
                                        child: Text(
                                          item['day'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.setStartDay(value['id']);
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.43,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  borderSide: const BorderSide(
                                      color: AppColor.borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                  borderSide: const BorderSide(
                                      color: AppColor.primaryColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                  elevation: 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColor.background)),
                              buttonStyleData: ButtonStyleData(
                                  height: 54.h,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h)),
                              isExpanded: true,
                              hint: Text(
                                "End Day",
                                style: AppFont.light14.copyWith(
                                  color: AppColor.textSoft,
                                ),
                              ),
                              items: controller.days
                                  .map((item) => DropdownMenuItem<dynamic>(
                                        value: item,
                                        child: Text(
                                          item['day'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.setEndDay(value['id']);
                              },
                            ),
                          ),
                        ],
                      ),
                      8.0.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.43,
                            child: InputText(
                              keyboardType: TextInputType.datetime,
                              controller: controller.startTimeController,
                              ontaped: () {
                                showTimePicker(
                                  context: context,
                                  initialTime:
                                      controller.selectedStartTime.value,
                                  initialEntryMode: TimePickerEntryMode.dial,
                                ).then((value) => controller.setStartTime(
                                    value ?? TimeOfDay.now(), context));
                              },
                              hintText: 'Start time',
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.43,
                            child: InputText(
                              keyboardType: TextInputType.datetime,
                              controller: controller.endTimeController,
                              ontaped: () {
                                showTimePicker(
                                        context: context,
                                        initialTime:
                                            controller.selectedEndTime.value,
                                        initialEntryMode:
                                            TimePickerEntryMode.dial)
                                    .then((value) => controller.setEndTime(
                                        value ?? TimeOfDay.now(), context));
                              },
                              hintText: 'End time',
                            ),
                          ),
                        ],
                      ),
                      16.0.height,
                      Text(
                        'Address',
                        style: AppFont.medium14,
                      ),
                      16.0.height,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.primaryColor,
                            size: 24.w,
                          ),
                          8.0.width,
                          Expanded(
                            child: Text(
                              controller.addressPicker.value,
                              style: AppFont.reguler12,
                            ),
                          )
                        ],
                      ),
                      8.0.height,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CommonStaticMap(
                          centerLocation: staticMap.Location(
                              controller.pickerLocation.value.latitude,
                              controller.pickerLocation.value.longitude),
                          ontap: () {
                            Get.to(() => MapPicker(
                                  point: LatLng(
                                      controller.pickerLocation.value.latitude,
                                      controller
                                          .pickerLocation.value.longitude),
                                  ontap: (value) {
                                    controller.setLocation(value);
                                  },
                                ));
                          },
                        ),
                      ),
                      16.0.height,
                      SecondaryButton(
                        icon: const Icon(
                          Icons.my_location_rounded,
                          color: AppColor.textSoft,
                          size: 16,
                        ),
                        backgroundColor: AppColor.cardColor,
                        borderColor: AppColor.background,
                        title: 'Set Location',
                        textColor: AppColor.textSoft,
                        onPressed: () {
                          Get.to(() => MapPicker(
                                point: LatLng(
                                    controller.pickerLocation.value.latitude,
                                    controller.pickerLocation.value.longitude),
                                ontap: (value) {
                                  controller.setLocation(value);
                                },
                              ));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColor.background,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: AppColor.primaryColor.withOpacity(0.15),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                disable: controller.isValidatePersonal.value,
                title: "Continue",
                loading: controller.isPostLoading.value,
                onPressed: () {
                  controller.postTerapist(context);
                },
                margin: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
              ),
              8.0.height,
              SecondaryButton(
                backgroundColor: AppColor.strokeColor,
                borderColor: AppColor.background,
                title: 'Cancel',
                textColor: AppColor.textSoft,
                onPressed: () {
                  Get.back();
                },
                margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
              ),
            ],
          ),
        ),
      );
    });
  }
}
