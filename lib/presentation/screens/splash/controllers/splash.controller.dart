import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    navigateLogin();
    setupLanguage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setupLanguage() async {
    int selectedLanguage = await inject<StorageService>().getSelectedLanguage();
    Locale locale;
    switch (selectedLanguage) {
      case 1:
        locale = Locale('id', 'ID'); // Indonesian
        break;
      case 2:
        locale = Locale('en', 'US'); // English
        break;
      default:
        locale = Get.deviceLocale!;
        break;
    }
    Get.updateLocale(locale);
  }

  void navigateLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      isLoading.value = false;
    });
  }
}
