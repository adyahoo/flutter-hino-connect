import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  LoginController({required this.useCase});

  final UserUseCase useCase;

  final emailState = AppTextFieldState();
  final passwordState = AppTextFieldState();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final isLoading = false.obs;
  final LocalAuthentication localAuth = LocalAuthentication();
  var isBiometricActive = false.obs;
  final isLoadingBio = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailState.focusNode.value.addListener(emailState.onFocusChange);
    passwordState.focusNode.value.addListener(passwordState.onFocusChange);
  }

  @override
  void onReady() {
    super.onReady();
    doLoginWithBiometric();
  }

  @override
  void onClose() {
    super.onClose();
    emailState.focusNode.value.removeListener(emailState.onFocusChange);
    passwordState.focusNode.value.removeListener(passwordState.onFocusChange);
  }

  void checkBiometric() {
    var isBiometric = inject<StorageService>().getIsBiometricLogin();
    isBiometricActive.value = isBiometric ?? false;
  }

  Future<void> doLogin() async {
    isLoading.value = true;

    final body = LoginBody(email: emailController.value.text, password: passwordController.value.text);
    await useCase.login(body);

    Get.offNamed(Routes.MAIN_TAB);
    isLoading.value = false;
  }

  Future<void> doLoginWithBiometric() async {
    checkBiometric();
    if (!isBiometricActive.value) {
      Get.bottomSheet(BsConfirmation(
        title: 'Fitur biometrik belum aktif',
        type: BsConfirmationType.warning,
        description:
            'Anda belum mengaktifkan biometrik pada aplikasi Hino Driver di perangkat Anda. Silakan login terlebih dahulu, kemudian aktifkan fitur “Login Biometrik” pada menu profil.',
        isMultiAction: false,
        positiveButtonOnClick: () {
          Get.back();
        },
        positiveTitle: 'Baik, saya mengerti',
      ));
      return;
    }

    isLoadingBio.value = true;
    print("doLoginWithBiometric");

    final bool canAuthenticateWithBiometrics =
        await localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();

    print("canAuthenticate $canAuthenticate");
    print('canAuthenticateWithBiometrics $canAuthenticateWithBiometrics');

    print('getAvailableBiometrics ${await localAuth.getAvailableBiometrics()}');

    final isAvailable = await localAuth.isDeviceSupported();
    print("isAvailable $isAvailable");
    if (isAvailable) {
      try {
        final isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );

        if (isAuthenticated) {
          inject<StorageService>().setToken(
              "ini email ${emailController.value.text} dan pass ${passwordController.value.text}");

          Get.offNamed(Routes.MAIN_TAB);
        } else {
          // Handle the case where the user cancels the authentication
          print('User cancelled authentication');
        }
      } catch (e) {
        // Handle the case where an error occurs
        print('Error occurred: $e');
      } finally {
        isLoadingBio.value = false;
      }
    }
  }
}
