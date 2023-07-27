import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pijetin/data/model/user/order_user/order_user_detail.dart';
import 'package:pijetin/data/model/user/therapist/therapist.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_controller.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';
import 'package:geocoding/geocoding.dart' as geo;
import '../../../data/model/user/order_user/order_ws.dart';
import '../../../utils/helper/custom_snackbar.dart';
import '../websocket_controller.dart';

class OrderDetailController extends GetxController {
  OrderDetailController(this.id);
  final int id;
  var isLoading = false.obs;
  var isLoadingFeedback = false.obs;
  var decodeLocation = "".obs;
  var orderUserDetail = OrderDetail().obs;
  var note = TextEditingController();
  var isFeedback = false.obs;
  var rating = 0.0.obs;

  @override
  void onInit() async {
    await getOrderDetail();
    Websocket.instance.subscribeOrderDetail(orderUserDetail.value.uid!);
    updateOrderDetail();
    super.onInit();
  }

  Future<void> getOrderDetail() async {
    isLoading.value = true;
    OrderRepository orderRepository = OrderRepository();
    final response = await orderRepository.getDetailOrder(id);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = orderDetailFromJson(response.body!);

      orderUserDetail.value = data;
      decodeLocation.value = await dacodeLocation(LatLng(
          orderUserDetail.value.location!.x!,
          orderUserDetail.value.location!.y!));
      orderUserDetail.refresh();
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  String rangeDuration() {
    DateTime dateTime = DateTime.parse(
        "${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${DateFormat.Hm().format(orderUserDetail.value.appointmentDate ?? DateTime.now())}:00");

    dateTime = dateTime
        .add(Duration(minutes: orderUserDetail.value.appointmentDuration!));

    String result =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return result;
  }

  Future<String> dacodeLocation(LatLng point) async {
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(point.latitude, point.longitude);
    if (placemarks.isNotEmpty) {
      geo.Placemark placemark = placemarks[0];

      return '${placemark.name}, ${placemark.subLocality}, ${placemark.locality} ${placemark.administrativeArea}, ${placemark.subAdministrativeArea} ${placemark.postalCode}';
    } else {
      return '';
    }
  }

  Therapist? selectedTherapis() {
    TherapistController therapistController = Get.find();
    final therapis = therapistController.therapistList
        .singleWhere((element) => element.id == orderUserDetail.value.id);

    return therapis;
  }

  toFeedback() async {
    isLoadingFeedback.value = true;
    OrderRepository orderRepository = OrderRepository();
    var body = {"rating": rating.toString(), "note": note.text};

    final response = await orderRepository.sendFeedback(body, id);
    log(response.body.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      getOrderDetail();

      Get.back();
      Get.snackbar("Success", "Feedback has sent",
          backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar("Failed", "something went wrong",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    isLoadingFeedback.value = false;
    Get.back();
  }

  cancelHistory() async {
    OrderRepository orderRepository = OrderRepository();
    final response = await orderRepository.changeState(
        id: orderUserDetail.value.id!, order: StateOrder.cancel);
    if (response.statusCode == 200 || response.statusCode == 201) {
      successSnackbar("Success", "order has been canceled");
      getOrderDetail();
      Get.close(1);
    } else {
      errorSnackbar("Error", response.body.toString());
    }
  }

  updateOrderDetail() {
    Websocket.instance.streamController.stream.listen((message) {
      if (message.contains("record")) {
        var wsOrder = OrderWs.fromJson(
            jsonDecode(message)["${orderUserDetail.value.uid}"]['record']);

        log(wsOrder.toString());
        if (orderUserDetail.value.uid == wsOrder.uid) {
          orderUserDetail.value.copyWith(updatedAt: wsOrder.updatedAt);
          orderUserDetail.value.copyWith(orderStatus: wsOrder.orderStatus);
          log(orderUserDetail.value.orderStatus.toString());
          if (wsOrder.orderStatus == 'paid' || wsOrder.orderStatus == 'done') {
            getOrderDetail();
          }

          orderUserDetail.refresh();
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
    Websocket.instance.unSubscribeOrder(orderUserDetail.value.uid!);
    super.onClose();
  }
}
