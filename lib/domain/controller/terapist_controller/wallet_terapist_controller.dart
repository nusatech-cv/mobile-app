import 'package:get/get.dart';
import 'package:pijetin/data/model/user/payment/history_payment_therapist.dart';
import 'package:pijetin/domain/repository/payment_repository/payment_reposistory.dart';

class WalletTerapistController extends GetxController {
  var listPayment = <HistoryPaymentTherapist>[].obs;
  var isLoading = false.obs;

  Future<void> getHistoryPayment() async {
    try {
      isLoading.value = true;
      PaymentRepository paymentRepository = PaymentRepository();

      final response = await paymentRepository.getHistoryPayment();

      if (response.statusCode == 200 && response.body != null) {
        var data = historyPaymentTherapistFromJson(response.body!);
        listPayment.assignAll(data);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e);
    }
  }

  @override
  void onInit() {
    getHistoryPayment();
    super.onInit();
  }
}
