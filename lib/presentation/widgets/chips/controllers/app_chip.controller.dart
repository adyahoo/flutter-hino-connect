import 'package:get/get.dart';

class AppChipController extends GetxController {

  final selectedId = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setIsSelected(String value) {
    selectedId.value = value;
    update();
  }
}
