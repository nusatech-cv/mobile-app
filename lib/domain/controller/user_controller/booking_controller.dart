import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/data/model/user/order_user/order_user_detail.dart';
import 'package:pijetin/data/model/user/therapist/therapist_detail.dart';
import 'package:pijetin/domain/controller/user_controller/order_user_controller.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';
import 'package:pijetin/utils/helper/custom_snackbar.dart';

import '../../../data/model/user/order_user/order_ws.dart';
import '../../../view/pages/user/booking/booking_waiting_page.dart';
import '../location_controller.dart';
import '../websocket_controller.dart';

class BookingController extends GetxController {
  final TherapistDetail therapistDetail;
  BookingController({required this.therapistDetail});
  late LocationController locationController;
  var selectedDate = DateTime.now().obs;
  var selectedHours = "".obs;
  var selectedDuration = 30.obs;
  var selectedService = ServiceTherapis().obs;
  var pickerLocation = const LatLng(0, 0).obs;
  var addressPicker = ''.obs;
  var isValidate = false.obs;
  var isLoading = false.obs;
  var order = OrderDetail().obs;

  var note = TextEditingController();
  var listHours = <String>[].obs;
  var isBookingConfirmed = false.obs;

  @override
  void onInit() {
    locationController = Get.find();
    setDefaultLocation();
    super.onInit();
  }

  setDefaultLocation() {
    pickerLocation.value = LatLng(
        locationController.currentLocation.value.latitude,
        locationController.currentLocation.value.longitude);
    addressPicker.value = locationController.address.value;
    log(addressPicker.value);
  }

  void setLocation(LatLng value) async {
    pickerLocation.value = value;
    addressPicker.value = await locationController.dacodeLocation(value);
    validateForm();
  }

  selectDate(DateTime dateTime) {
    selectedDate.value = dateTime;
    if (selectedHours.value != '') {
      selectedDate.value = selectedDate.value.add(Duration(
          hours: int.parse((selectedHours.value).split(":").first),
          minutes: int.parse((selectedHours.value).split(":").last)));
    }
  }

  selectHours(String hour) {
    selectedHours.value = hour;
    if (selectedDate.value.hour == 0) {
      selectedDate.value = selectedDate.value.add(Duration(
          hours: int.parse((hour).split(":").first),
          minutes: int.parse((hour).split(":").last)));
    } else {
      selectedDate.value = DateTime(selectedDate.value.year,
          selectedDate.value.month, selectedDate.value.day);
      selectedDate.value = selectedDate.value.add(Duration(
          hours: int.parse((hour).split(":").first),
          minutes: int.parse((hour).split(":").last)));
    }

    selectedDuration.value = 30;
  }

  addDuration(List<String> listDate) {
    final remainDate = listDate.indexOf(selectedHours.value);
    final remainListDate = listDate.sublist(remainDate);

    final length = remainListDate.length;
    if (selectedDuration.value < (length * 2) * 30) {
      selectedDuration.value += 30;
    }
  }

  setService(ServiceTherapis value) {
    selectedService.value = value;
  }

  reduceDuration() {
    if (selectedDuration.value > 30) {
      selectedDuration.value -= 30;
    }
  }

  List<String> generateTimeRange(String startTime, String endTime,
      {int stepMinutes = 60}) {
    DateTime start = DateTime.parse('1970-01-01 $startTime');
    DateTime end = DateTime.parse('1970-01-01 $endTime');

    List<String> timeRange = [];
    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      timeRange.add(start.toLocal().toString().split(' ')[1].substring(0, 5));
      start = start.add(Duration(minutes: stepMinutes));
    }

    return timeRange;
  }

  findBooking() async {}

  String rangeDuration() {
    DateTime dateTime = DateTime.parse(
        "${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${selectedHours.value}:00");

    dateTime = dateTime.add(Duration(minutes: selectedDuration.value));

    String result =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return result;
  }

  validateForm() {
    if (selectedHours.value.isNotEmpty &&
        selectedService.value.serviceId != null &&
        pickerLocation.value.latitude != 0 &&
        pickerLocation.value.longitude != 0) {
      isValidate.value = true;
    } else {
      isValidate.value = false;
    }
  }

  Future<void> postBooking() async {
    try {
      OrderRepository orderRepository = OrderRepository();
      OrderUserController orderUserController =
          Get.isRegistered() ? Get.find() : Get.put(OrderUserController());
      isLoading.value = true;
      var body = {
        "service_id": selectedService.value.serviceId,
        "therapist_id": therapistDetail.id,
        "appointment_date": selectedDate.value.toIso8601String(),
        "appointment_duration": selectedDuration.value,
        "location": jsonEncode({
          "x": pickerLocation.value.latitude,
          "y": pickerLocation.value.longitude
        }),
        "note": note.text
      };

      final response = await orderRepository.createOrder(body);
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        order.value = OrderDetail.fromJson(jsonDecode(response.body!)['data']);
        successSnackbar("Success", "order has been created");
        Get.close(3);
        orderUserController.getOrderUser();
        Get.to(() => BookingWaitingPage());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        errorSnackbar("Error", "Failed create order");
      }
    } catch (e) {
      isLoading.value = false;
      errorSnackbar("Error", e.toString());
    }
  }

  changeStateOrder() async {
    OrderRepository orderRepository = OrderRepository();
    final response = await orderRepository.changeState(
        id: order.value.id!, order: StateOrder.cancel);
    if (response.statusCode == 200 || response.statusCode == 201) {
      successSnackbar("Success", "order has been canceled");
      Get.close(2);
    } else {
      errorSnackbar("Error", response.body.toString());
    }
  }

  Future<void> getOrder() async {
    isLoading.value = true;
    OrderRepository orderRepository = OrderRepository();
    final response = await orderRepository.getDetailOrder(order.value.id!);

    if (response.statusCode == 200) {
      var data = orderDetailFromJson(response.body!);
      order.value = data;
      order.refresh();
      Websocket.instance.subscribeOrderDetail(data.uid!);
      updateOrders();
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  updateOrders() {
    Websocket.instance.streamController.stream.listen((message) {
      if (message.contains("record")) {
        var wsOrder = OrderWs.fromJson(
            jsonDecode(message)["${order.value.uid}"]['record']);

        if (order.value.uid == wsOrder.uid) {
          log(wsOrder.createdAt.toString());
          order.value.copyWith(updatedAt: wsOrder.updatedAt);
          order.value.copyWith(orderStatus: wsOrder.orderStatus);

          order.refresh();
        }
      }
    }, onDone: () {
      log("on Done");
    }, onError: (error) {
      log("error ws => $error");
    });
  }

  @override
  void onClose() {
    Websocket.instance.unSubscribeOrder(order.value.uid!);
    super.onClose();
  }
}
