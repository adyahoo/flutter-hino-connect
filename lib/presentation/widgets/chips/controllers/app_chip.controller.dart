import 'package:get/get.dart';

class AppChipController extends GetxController {
  // final RxInt count = 0.obs;

  final isSelected = false.obs;

  // void increment() {
  //   count.value++;
  // }

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

  void setIsSelected(bool value) {
    isSelected.value = value;
    update();
  }

}