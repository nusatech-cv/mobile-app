import 'dart:developer';

import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';

enum StateOrder { accept, paid, startOrder, endOrder, cancel }

class OrderRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponseData> getOrderUser() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('orders');

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> getDetailOrder(int id) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('orders/$id');

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> sendFeedback(Map body, int id) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    // apiClient.headers!.addAll(
    //     {"Accept": 'application/json', 'Content-Type': 'application/json'});

    try {
      final response = await apiClient.post('orders/$id/ratings', body);

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> createOrder(Map body) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    try {
      final response = await apiClient.post('orders', body);

      log(response.body.toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> changeState(
      {required int id, required StateOrder order}) {
    String setState(StateOrder order) {
      switch (order) {
        case StateOrder.accept:
          return "waiting_payment";
        case StateOrder.paid:
          return "paid";
        case StateOrder.startOrder:
          return "appointment_start";
        case StateOrder.endOrder:
          return "done";
        case StateOrder.cancel:
          return "cancel";
        default:
          return "cancel";
      }
    }

    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    String state = setState(order);
    log(state.toString());
    try {
      final response = apiClient.put('orders/$id/$state', {});
      return response;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
