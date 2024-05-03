import 'package:get/get.dart';

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
  }

  @override
  void onClose() {
    super.onClose();
  }

  void navigateLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      isLoading.value = false;
    });
  }
}
