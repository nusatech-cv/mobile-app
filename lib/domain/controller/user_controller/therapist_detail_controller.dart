import 'package:get/get.dart';
import 'package:pijetin/data/model/user/therapist/therapist_detail.dart';
import 'package:pijetin/domain/repository/repository.dart';

class TherapistDetailController extends GetxController {
  var isLoading = false.obs;
  var therapist = TherapistDetail().obs;

  List<dynamic> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  Future<void> getTherapists(int id) async {
    isLoading.value = true;
    TherapistRepository therapistRepository = TherapistRepository();
    final response = await therapistRepository.getTherapistDetail(id);
    therapist.value = response;
    therapist.refresh();

    isLoading.value = false;
  }
}
