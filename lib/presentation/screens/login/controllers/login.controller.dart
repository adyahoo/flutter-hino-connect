import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class LoginController extends GetxController {
  final emailState = AppTextFieldState();
  final passwordState = AppTextFieldState();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailState.focusNode.value.addListener(emailState.onFocusChange);
    passwordState.focusNode.value.addListener(passwordState.onFocusChange);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailState.focusNode.value.removeListener(emailState.onFocusChange);
    passwordState.focusNode.value.removeListener(passwordState.onFocusChange);
  }

  Future<void> doLogin() async {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 2000), () {
      inject<StorageService>().setToken("ini email ${emailController.value.text} dan pass ${passwordController.value.text}");

      Get.offNamed(Routes.MAIN_TAB);
      isLoading.value = false;
    });
  }
}
