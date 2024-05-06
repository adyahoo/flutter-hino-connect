import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailState = AppTextFieldState();
  final passwordState = AppTextFieldState();

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
}
