// ignore_for_file: library_prefixes
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/model/user/therapist/therapist_detail.dart';
import 'package:pijetin/domain/controller/user_controller/booking_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/booking/review_booking_page.dart';
import 'package:pijetin/view/widget/disable_button.dart';
import 'package:pijetin/view/widget/map_picker.dart';
import 'package:pijetin/view/widget/widget.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
    as staticMap;

class BookingPage extends StatefulWidget {
  final TherapistDetail therapist;
  const BookingPage({super.key, required this.therapist});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late BookingController controller;

  @override
  void initState() {
    controller = Get.put(BookingController(therapistDetail: widget.therapist));
    // controller.setHours(widget.therapist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.appBar(title: 'Booking Appointment'),
      bottomNavigationBar: Obx(() {
        return Container(
            decoration: BoxDecoration(color: AppColor.background, boxShadow: [
              BoxShadow(
                  color: AppColor.strokeColor,
                  spreadRadius: 1.h,
                  blurRadius: 1.h)
            ]),
            padding: const EdgeInsets.all(24),
            child: !controller.isValidate.value
                ? const DisabledButton(title: "Next")
                : PrimaryButton(
                    title: "Next",
                    onPressed: () {
                      Get.to(() => ReviewBookingPage());
                    }));
      }),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.0.height,
                Text(
                  "Select Date",
                  style: AppFont.medium16,
                ),
                16.0.height,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColor.cardColor,
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        nextMonthIcon: const Icon(
                          Icons.navigate_next,
                          color: AppColor.textStrong,
                        ),
                        lastMonthIcon: const Icon(
                          Icons.navigate_before,
                          color: AppColor.textStrong,
                        ),
                        firstDate: DateTime.now(),
                        dayTextStyle:
                            AppFont.medium14.copyWith(color: AppColor.textSoft),
                        controlsTextStyle: AppFont.medium16,
                        weekdayLabelTextStyle: AppFont.medium16,
                        calendarType: CalendarDatePicker2Type.single,
                        calendarViewMode: DatePickerMode.day),
                    value: [controller.selectedDate.value],
                    onValueChanged: (value) {
                      controller.selectDate(value.first ?? DateTime.now());
                    },
                  ),
                ),
                24.0.height,
                Text(
                  "Select Service",
                  style: AppFont.medium14,
                ),
                8.0.height,
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      borderSide: const BorderSide(color: AppColor.borderColor),
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
                    "Select Service",
                    style: AppFont.light14.copyWith(
                      color: AppColor.textSoft,
                    ),
                  ),
                  items: widget.therapist.services!
                      .map((item) => DropdownMenuItem<ServiceTherapis>(
                            value: item,
                            child: Text(
                              item.name!.capitalize ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.setService(value ?? ServiceTherapis());
                    controller.validateForm();
                  },
                ),
                24.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Hours",
                      style: AppFont.medium14,
                    ),
                    Text(
                      DateFormat("EEEE, dd MMMM yyyy")
                          .format(controller.selectedDate.value),
                      style: AppFont.reguler14,
                    ),
                  ],
                ),
                8.0.height,
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      borderSide: const BorderSide(color: AppColor.borderColor),
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
                    "Select Hours",
                    style: AppFont.light14.copyWith(
                      color: AppColor.textSoft,
                    ),
                  ),
                  items: controller
                      .generateTimeRange(widget.therapist.startTime!,
                          widget.therapist.endTime!)
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
                    controller.selectHours(value ?? "");
                    controller.validateForm();
                  },
                ),
                16.0.height,
                Text(
                  "Select Duration",
                  style: AppFont.medium14,
                ),
                8.0.height,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 54.h,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.borderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${controller.selectedDuration.value} min",
                              style: AppFont.reguler14.copyWith(
                                color: AppColor.textSoft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    8.0.width,
                    SecondaryButtonV2(
                      title: "",
                      onPressed: () {
                        controller.reduceDuration();
                      },
                      width: 60.w,
                      height: 60.w,
                      icon: Icon(
                        Icons.do_disturb_on_outlined,
                        size: 24.w,
                        color: AppColor.textSoft,
                      ),
                    ),
                    8.0.width,
                    SecondaryButtonV2(
                      title: "",
                      onPressed: () {
                        controller.addDuration(controller.generateTimeRange(
                            widget.therapist.startTime!,
                            widget.therapist.endTime!));
                      },
                      width: 60.w,
                      height: 60.w,
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 24.w,
                        color: AppColor.textSoft,
                      ),
                    ),
                  ],
                ),
                24.0.height,
                Text(
                  "Select Location",
                  style: AppFont.medium16,
                ),
                16.0.height,
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 24.w,
                      color: AppColor.primaryColor,
                    ),
                    12.0.width,
                    Expanded(
                      child: Text(
                        controller.addressPicker.value,
                        style: AppFont.medium14,
                      ),
                    ),
                  ],
                ),
                16.0.height,
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
                                    controller.pickerLocation.value.longitude),
                                ontap: (value) {
                                  controller.setLocation(value);
                                  controller.validateForm();
                                },
                              ))!
                          .then((value) => controller.validateForm());
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
                16.0.height,
                Text(
                  "Note For Therapist",
                  style: AppFont.medium16,
                ),
                16.0.height,
                InputText(
                  hintText: "Note",
                  controller: controller.note,
                  maxLine: 6,
                  textInputAction: TextInputAction.done,
                ),
                16.0.height,
              ],
            ),
          ),
        );
      }),
    );
  }
}
