import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

class BsSinglePickerController extends GetxController {
  // final selectedOption = 0.obs;

  var selectedOption =
      (inject<StorageService>().getSelectedLanguage() ?? 0).obs;
  final isFetching = false.obs;

  void setSelectedOption(int id) {
    print('selectedOption: ${selectedOption.value}');
    selectedOption.value = id;
    print('selectedOption check: $id');
  }

  Future<void> changeLanguage(int id) async {
    isFetching.value = true;
    print('abis isFetching true');
    selectedOption.value = id;
    inject<StorageService>().setSelectedLanguage(id);
    update();
    print('abis update');

    Get.back();

    await Future.delayed(Duration(milliseconds: 500)); 
    
    // Update the locale
    switch (id) {
      case 1:
        Get.updateLocale(Locale('id', 'ID')); // Indonesian
        break;
      case 2:
        Get.updateLocale(Locale('en', 'US')); // English
        break;
    }
    print('abis Get.updateLocale');
    isFetching.value = false;
    print('abis isFetching false');
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
