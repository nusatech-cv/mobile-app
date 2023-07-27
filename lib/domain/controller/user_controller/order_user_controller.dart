import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pijetin/data/model/user/order_user/order_user.dart';
import 'package:pijetin/data/model/user/order_user/order_ws.dart';
import 'package:pijetin/domain/repository/order_user_repository/order_user_repository.dart.dart';

import '../websocket_controller.dart';

class OrderUserController extends GetxController {
  var selectedTabIndex = 0.obs;
  var orderList = <Order>[].obs;
  var isLoading = false.obs;
  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    getOrderUser();
    updateOrders();
    super.onInit();
  }

  Future<void> getOrderUser() async {
    isLoading.value = true;
    OrderRepository historyUserRepository = OrderRepository();

    final response = await historyUserRepository.getOrderUser();
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = orderFromJson(response.body!);

      orderList.assignAll(data);
    }

    isLoading.value = false;
  }

  updateOrders() {
    Websocket.instance.streamController.stream.listen((message) {
      if (message.contains('record')) {
        log("message ws ==> $message");

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
}
