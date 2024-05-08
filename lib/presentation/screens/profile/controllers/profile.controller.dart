import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

import '../../../../infrastructure/di.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  var isBiometricLogin = (inject<StorageService>().getIsBiometricLogin() ?? false).obs;

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

  void increment() => count.value++;

  void toggleSwitch(bool isBiometricLogin) {
    this.isBiometricLogin.value = isBiometricLogin;
    inject<StorageService>().setIsBiometricLogin(isBiometricLogin);
    update();
    print('isBiometricLogin check: $isBiometricLogin');
  }

  void navigateToFeedback() {
    print('navigateToFeedback');
    Get.toNamed(Routes.FEEDBACK);
  }
}