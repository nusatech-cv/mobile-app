import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pijetin/data/model/user/order_user/order_ws.dart';
import 'package:pijetin/domain/controller/location_controller.dart';
import 'package:pijetin/view/pages/terapist/DetailBookingTerapist/components/appointment_duration.dart';

import '../../../data/model/user/order_user/order_user_detail.dart';
import '../../../utils/helper/custom_snackbar.dart';
import '../../../view/pages/terapist/DetailBookingTerapist/components/appointment_finished.dart';
import '../../repository/order_user_repository/order_user_repository.dart.dart';
import '../websocket_controller.dart';

class AppointmentDetailController extends GetxController {
  final int id;
  AppointmentDetailController({required this.id});
  LocationController locationController = Get.find();
  var isConfirmed = true.obs;
  var finishDisable = true.obs;
  var isActive = false.obs;
  var isLoading = false.obs;
  var decodeLocation = "".obs;

  var orderUserDetail = OrderDetail().obs;

  Timer? countdownTimer;
  var myDuration = const Duration(minutes: 60).obs;

  @override
  void onInit() async {
    await getDetailOrder();
    Websocket.instance.subscribeOrderDetail(orderUserDetail.value.uid!);
    updateOrderDetail();
    super.onInit();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    int seconds = myDuration.value.inSeconds;
    if (seconds < 0) {
      countdownTimer!.cancel();
      isActive.value = false;
    } else {
      seconds--;
      myDuration.value = Duration(seconds: seconds);
      isActive.value = true;
    }
  }

  void stopTimer() {
    countdownTimer?.cancel();
    isActive.value = false;
  }

  Future<void> getDetailOrder() async {
    isLoading.value = true;
    orderUserDetail.value = OrderDetail();
    try {
      OrderRepository orderRepository = OrderRepository();
      final response = await orderRepository.getDetailOrder(id);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = orderDetailFromJson(response.body!);

        orderUserDetail.value = data;

        myDuration.value = Duration(minutes: data.appointmentDuration ?? 0);

        decodeLocation.value = await locationController.dacodeLocation(LatLng(
            orderUserDetail.value.location!.x!,
            orderUserDetail.value.location!.y!));
        orderUserDetail.refresh();
        isLoading.value = false;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  changeStateOrder(StateOrder order, String message) async {
    OrderRepository orderRepository = OrderRepository();

    final response = await orderRepository.changeState(
        id: orderUserDetail.value.id!, order: order);

    if (response.statusCode == 201 || response.statusCode == 200) {
      successSnackbar("Success", message);
      getDetailOrder();
      if (order == StateOrder.accept) {
        Get.close(1);
        Get.back();
      } else if (order == StateOrder.startOrder) {
        Get.close(1);
        Get.to(() => AppointentDuration());
        startTimer();
      } else if (order == StateOrder.cancel) {
        Get.back();
      } else {
        Get.close(1);
        Get.to(() => const AppointmentFinished());
      }
    } else {
      errorSnackbar("Error", response.body.toString());
    }
  }

  updateOrderDetail() {
    Websocket.instance.streamController.stream.listen((message) {
      log(message.toString());

      if (message.contains("record")) {
        var wsOrder = OrderWs.fromJson(
            jsonDecode(message)["${orderUserDetail.value.uid}"]['record']);

        if (orderUserDetail.value.uid == wsOrder.uid) {
          log(wsOrder.createdAt.toString());
          orderUserDetail.value.copyWith(updatedAt: wsOrder.updatedAt);
          orderUserDetail.value.copyWith(orderStatus: wsOrder.orderStatus);
          if (wsOrder.orderStatus == 'paid' || wsOrder.orderStatus == 'done') {
            getDetailOrder();
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
