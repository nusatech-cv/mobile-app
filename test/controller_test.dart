import 'package:get/get.dart';

class ControllerTest extends GetxController {
  @override
  void onInit() {
    super.onInit();
    name.value = 'Osiris';
  }

  @override
  void onClose() {
    name.value = '';
    super.onClose();
  }

  final name = 'Obelisk'.obs;

  void changeName() => name.value = 'Ra';
}
