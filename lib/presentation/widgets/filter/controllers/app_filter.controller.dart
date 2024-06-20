import 'package:get/get.dart';

class AppFilterController extends GetxController {
  final selectedId = ''.obs;

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

  void setSelectedId(String id){
    if(selectedId.value == id) {
      this.selectedId.value = '';
      return;
    }

    this.selectedId.value = id;
  }

  void clearSelectedId(){
    this.selectedId.value = '';
  }
}