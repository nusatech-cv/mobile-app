import 'dart:developer';

import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/therapist/therapist_detail.dart';

class TherapistRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponseData> getTherapist() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('therapists');

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> getFilterTherapist(
      {int? rating, int? service}) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get(
          'therapists?sort_by=popularity&sort_dir=desc&rating=$rating&service_id=$service');
      log(response.body.toString());
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TherapistDetail> getTherapistDetail(int id) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('therapists/$id');
      if (response.statusCode == 200) {
        log(response.body!);
        return therapistDetailFromJson(response.body!);
      }
      return TherapistDetail();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
