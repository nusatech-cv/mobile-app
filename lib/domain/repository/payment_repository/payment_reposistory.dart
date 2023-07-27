import 'dart:developer';

import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/data/data.dart';

import '../../../config/network/request_header.dart';

class PaymentRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponseData> getHistoryPayment() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    try {
      final response = await apiClient.get('therapists/payments');
      log(response.body.toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> postPaytment({body, required int id}) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    try {
      final response = await apiClient.post('users/$id/payments', body);
      log(response.body.toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
