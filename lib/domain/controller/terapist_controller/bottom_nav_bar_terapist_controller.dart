import 'package:get/get.dart';

class BottomNavBarTerapistController extends GetxController {
  var bottomNavBarTerapistIndex = 0.obs;

  changeBottomNavBarTerapistIndex(int index) =>
      bottomNavBarTerapistIndex.value = index;
}
