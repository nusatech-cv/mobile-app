import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';

import '../../../data/model/user/order_user/order_user.dart';
import '../../../data/model/user/order_user/order_ws.dart';
import '../websocket_controller.dart';

class HistoryOrderTerapistController extends GetxController {
  var isLoading = false.obs;
  var tabHistoryOrder = 0.obs;
  var listOrderHistory = <Order>[].obs;

  @override
  void onInit() {
    getOrderUser();
    super.onInit();
  }

  changeTabHistoryOrder(int index) => tabHistoryOrder.value = index;

  Future<void> getOrderUser() async {
    try {
      isLoading.value = true;
      OrderRepository orderRepository = OrderRepository();

      final response = await orderRepository.getOrderUser();
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = orderFromJson(response.body!);

        listOrderHistory.assignAll(data);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e);
    }
  }

  updateOrders() {
    Websocket.instance.streamController.stream.listen((message) {
      if (message.contains('record')) {
        for (Order order in listOrderHistory) {
          if (message.contains('${order.uid}')) {
            var wsOrder =
                OrderWs.fromJson(jsonDecode(message)["${order.uid}"]['record']);
            if (order.uid == wsOrder.uid) {
              order.copyWith(orderStatus: wsOrder.orderStatus);
              order.copyWith(updatedAt: wsOrder.updatedAt);
            }
          }
        }
        listOrderHistory.refresh();
      }
    }, onDone: () {
      log("on Done");
    }, onError: (error) {
      log("error ws => $error");
    });
  }
}
