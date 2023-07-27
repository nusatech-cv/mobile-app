import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';

import '../../../config/network/api_client.dart';

class AuthRepository {
  ApiClient apiClient = ApiClient();
  Future<ApiResponseData> signIn(String accessToken) async {
    apiClient.headers = {"Content-Type": "application/json"};
    try {
      var body = {
        'access_token': accessToken,
      };
      var response = await apiClient.post("auth/google", body);
      log(response.statusCode.toString());
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ApiResponseData> updateRole(String role) async {
    RequestHeaders requestHeaders = RequestHeaders();
    final headers = requestHeaders.setAuthHeaders();
    apiClient.headers = headers;
    try {
      var body = {
        'role': role,
      };
      var response = await apiClient.put('users/role', body);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ApiResponseData> postServiceTerapist(int serviceId) async {
    RequestHeaders requestHeaders = RequestHeaders();
    final headers = requestHeaders.setAuthHeaders();
    apiClient.headers = headers;
    try {
      String url = 'users/therapists/services';
      var body = {
        "service_id": serviceId,
      };
      log(body.toString());
      var response = await apiClient.post(url, body);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ApiResponseData> deleteService(int serviceId) async {
    RequestHeaders requestHeaders = RequestHeaders();
    final headers = requestHeaders.setAuthHeaders();
    apiClient.headers = headers;
    try {
      var response = await apiClient.delete(
        'users/therapists/services/$serviceId/delete',
      );
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ApiResponseData> fetcUser() async {
    RequestHeaders requestHeaders = RequestHeaders();
    final headers = requestHeaders.setAuthHeaders();
    apiClient.headers = headers;
    apiClient.headers!.remove('Content-Type');
    try {
      String url = 'users/me';
      var response = await apiClient.get(url);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ApiResponseData> postTherapist(http.MultipartRequest request) async {
    RequestHeaders requestHeaders = RequestHeaders();
    final header = requestHeaders.setAuthHeaders();
    header.remove('Content-Type');
    request.headers.addAll(header);
    var response = await apiClient.multiPart(request);

    return response;
  }
}
