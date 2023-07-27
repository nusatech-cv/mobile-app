import 'dart:developer';

import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';

class ActivityRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponseData> getListActivity() async {
    try {
      RequestHeaders headers = RequestHeaders();
      apiClient.headers = headers.setAuthHeaders();

      final response = await apiClient.get('users/activity');
      log(response.statusCode.toString());
      log(response.body.toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
