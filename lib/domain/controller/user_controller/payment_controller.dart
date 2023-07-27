import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pijetin/data/model/user/payment/payment_user.dart';
import 'package:pijetin/domain/controller/user_controller/order_detail_controller.dart';
import 'package:pijetin/view/pages/user/booking/booking_detail_page.dart';

import '../../../utils/helper/custom_snackbar.dart';
import '../../../view/pages/user/booking/components/step2_payment_e_wallet.dart';
import '../../repository/order_user_repository/order_user_repository.dart.dart';
import '../../repository/user_repository/payment_repository.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var listPayment = <String>["Ovo", "Dana", "BIDR"].obs;
  var selectedPayment = "".obs;
  final numberController = TextEditingController();
  var paymentUser = PaymentUser().obs;
  var disablebutton1 = true.obs;
  var disablebutton2 = true.obs;
  Timer? countdownTimer;
  var myDuration = const Duration(minutes: 5).obs;

  void changeSelectedPayment(String value) {
    selectedPayment.value = value;
    validateButton1();
  }

  onNumberChange(String value) {
    validateButton2();
  }

  validateButton1() {
    if (selectedPayment.value != '') {
      disablebutton1.value = false;
    } else {
      disablebutton1.value = true;
    }
  }

  validateButton2() {
    if (numberController.text != '') {
      disablebutton2.value = false;
    } else {
      disablebutton2.value = true;
    }
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    int seconds = myDuration.value.inSeconds;
    if (seconds <= 0) {
      countdownTimer!.cancel();
    } else {
      seconds--;
      myDuration.value = Duration(seconds: seconds);
    }
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  Future<void> postPayment(int id) async {
    try {
      isLoading.value = true;
      PaymentRepository paymentRepository = PaymentRepository();
      var body = {
        "payment_method": selectedPayment.value,
        "account_number": numberController.text
      };
      final response =
          await paymentRepository.postPaymentUser(id: id, body: body);
      log(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        paymentUser.value =
            PaymentUser.fromJson(jsonDecode(response.body!)['data']);
        var duration = paymentUser.value.paymentExpired!
            .difference(DateTime.now())
            .inMinutes;
        myDuration.value = Duration(minutes: duration);
        successSnackbar("Success", "Confirmation payment is succesfuly");
        Get.to(() => Step2PaymentEwallet(
              id: id,
            ));
        startTimer();
        isLoading.value = false;
      } else {
        errorSnackbar("Error", "Failed pay appointment");
        isLoading.value = false;
      }

      isLoading.value = false;
    } catch (e) {
      errorSnackbar("Error", e.toString());
      isLoading.value = false;
    }
  }

  confirmPayment({required int id}) async {
    OrderRepository orderRepository = OrderRepository();
    OrderDetailController orderController = Get.find();
    final response =
        await orderRepository.changeState(id: id, order: StateOrder.paid);

    if (response.statusCode == 201 || response.statusCode == 200) {
      stopTimer();
      successSnackbar("Success", "Confirmation payment is succesfuly");
      orderController.getOrderDetail();
      Get.close(4);
      Get.to(() => DetailBookingPage(id: id));
    } else {
      errorSnackbar("Error", response.body.toString());
    }
  }
}
