import 'package:pijetin/config/network/api_client.dart';
import 'package:pijetin/config/network/request_header.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/data/model/user/payment/payment.dart';

class PaymentRepository {
  ApiClient apiClient = ApiClient();

  Future<List<Payment>> getPayment(userId) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient
          .get('payments?user_id=$userId&sort_by=created_at&sort_dir=desc');
      if (response.statusCode == 200) {
        return paymentFromJson(response.body!);
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseData> postPaymentUser({body, required int id}) async {
    RequestHeaders headers = RequestHeaders();
    apiClient.headers = headers.setAuthHeaders();

    try {
      final response = await apiClient.post('orders/$id/payments', body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
