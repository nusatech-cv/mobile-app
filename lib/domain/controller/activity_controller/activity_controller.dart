import 'package:get/get.dart';
import 'package:pijetin/data/model/user/activity/activity_histories.dart';
import 'package:pijetin/domain/repository/activity_repository/activity_repository.dart';

class ActivityController extends GetxController {
  var isLoading = false.obs;
  var listActivity = <ActivityHistories>[].obs;

  @override
  void onInit() {
    getActivityHistories();
    super.onInit();
  }

  Future<void> getActivityHistories() async {
    ActivityRepository activityRepository = ActivityRepository();
    try {
      isLoading.value = true;
      final response = await activityRepository.getListActivity();
      if (response.statusCode == 200) {
        var data = activityHistoriesFromJson(response.body!);
        listActivity.value = data;
        listActivity.sort(  



          
          (a, b) => b.createdAt!.compareTo(a.createdAt!),
        );
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
