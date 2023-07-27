import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/model/user/order_user/order_ws.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';

import '../../../data/model/user/order_user/order_user.dart';
import '../../repository/repository.dart';
import '../websocket_controller.dart';

class HomeTerapistController extends GetxController {
  var tabBookingUserIndex = 0.obs;
  var isLoading = false.obs;
  var isHistoryLoading = false.obs;
  var orderList = <Order>[].obs;

  var orderListDone = <Order>[].obs;

  @override
  void onInit() async {
    Websocket.instance.onInit();

    subscribeNotification();
    getOrderUser();
    updateOrders();
    super.onInit();
  }

  void changeTabBookingIndex(int index) => tabBookingUserIndex.value = index;

  Future<void> getOrderUser() async {
    try {
      isHistoryLoading.value = true;
      OrderRepository orderRepository = OrderRepository();

      final response = await orderRepository.getOrderUser();
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = orderFromJson(response.body!);
        orderList.assignAll(data);
      }
      isHistoryLoading.value = false;
    } catch (e) {
      isHistoryLoading.value = false;
      throw Exception(e);
    }
  }

  updateOrders() {
    Websocket.instance.streamController.stream.listen((message) {
      if (message.contains('record')) {
        for (Order order in orderList) {
          if (message.contains('${order.uid}')) {
            var wsOrder =
                OrderWs.fromJson(jsonDecode(message)["${order.uid}"]['record']);
            if (order.uid == wsOrder.uid) {
              order.copyWith(orderStatus: wsOrder.orderStatus);
              order.copyWith(updatedAt: wsOrder.updatedAt);
            }
          }
        }
        orderList.refresh();
      }
    }, onDone: () {
      log("on Done");
    }, onError: (error) {
      log("error ws => $error");
    });
  }

  subscribeNotification() async {
    UserRepository userRepository = UserRepository();
    var token = await FirebaseMessaging.instance.getToken();
    await userRepository.subscribeNotififcation(token ?? "");
  }
}
