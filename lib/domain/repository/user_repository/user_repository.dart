import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';

class UserRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponseData> getProfile() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get(
        'users/me',
      );

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> subscribeNotififcation(String token) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();
    apiClient.headers!.remove('Content-Type');

    try {
      await apiClient.post(
        'users/registration_token',
        {'registration_token': token},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
