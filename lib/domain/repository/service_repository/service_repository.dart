import 'dart:developer';

import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/model/user/service/service.dart';

class ServiceRepository {
  ApiClient apiClient = ApiClient();

  Future<List<Service>> getServices() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('services');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return serviceFromJson(response.body!);
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
