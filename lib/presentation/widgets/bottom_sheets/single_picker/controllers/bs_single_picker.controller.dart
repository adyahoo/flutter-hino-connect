import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';

class BsSinglePickerController extends GetxController {
  final selectedOption = 0.obs;
  final isFetching = false.obs;

  void setSelectedOption(int id) {
    selectedOption.value = id;
  }

  Future<void> changeLanguage(int id) async {
    isFetching.value = true;
    // selectedOption.value = id;
    // inject<StorageService>().setSelectedLanguage(id);
    // update();

    // Get.back();

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
        selectedOption.value = id;
    inject<StorageService>().setSelectedLanguage(id);
    // update();

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
