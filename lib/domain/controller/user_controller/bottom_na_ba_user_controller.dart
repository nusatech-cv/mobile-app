import 'package:get/get.dart';

class BottomNavBarUserController extends GetxController {
  var bottomNavBarUserIndex = 0.obs;

  changeBottomNavBarUserIndex(int index) => bottomNavBarUserIndex.value = index;
}
