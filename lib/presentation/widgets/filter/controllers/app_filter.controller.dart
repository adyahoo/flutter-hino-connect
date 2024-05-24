import 'package:get/get.dart';

class AppFilterController extends GetxController {
  final selectedChipId = ''.obs;

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

  void handleChipSelection(String chipId, bool isSelected) {
    if (isSelected) {
      selectedChipId.value = chipId;
    } else if (selectedChipId.value == chipId) {
      // If the currently selected chip is deselected, clear the selectedChipId
      selectedChipId.value = '';
    }
    update();
  }
}