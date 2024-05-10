import 'package:get/get.dart';

class BsSinglePickerController extends GetxController {
  final selectedOption = 0.obs;

  void setSelectedOption(int id){
    selectedOption.value = id;
  }

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
}
