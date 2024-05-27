import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class LoginController extends GetxController {
  LoginController({required this.useCase});

  final UserUseCase useCase;

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

    final body = LoginBody(email: emailController.value.text, password: passwordController.value.text);
    await useCase.login(body);

    Get.offNamed(Routes.MAIN_TAB);
    isLoading.value = false;
  }
}
