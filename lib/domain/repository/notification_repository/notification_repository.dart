import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/model/user/notification/notification_model.dart';

class NotificationRepository {
  ApiClient apiClient = ApiClient();

  Future<List<NotificationModel>?> getListNotification() async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.get('users/notification');
      if (response.statusCode == 200) {
        return notificationModelFromJson(response.body!);
      }

      return [];
    } catch (e) {
      return null;
      // throw Exception(e.toString());
    }
  }

  Future<bool> readNotification(int notifId) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.put('users/notification/$notifId', {
        "notif_id": notifId,
        "is_read": true,
      });

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
