import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/dtos/api_dto.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../infrastructure/di.dart';

class ProfileController extends GetxController {
  ProfileController({required this.useCase});

  final UserUseCase useCase;

  final data = Rx<UserModel>(UserModel(
    id: 0,
    name: '',
    email: '',
    profilePic: '',
    phoneCode: '',
    phone: '',
  ));
  final isFetching = true.obs;

  final isBiometricLogin = (inject<StorageService>().getIsBiometricLogin() ?? false).obs;
  final LocalAuthentication localAuth = LocalAuthentication();
  final isLoadingBio = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUser() async {
    isFetching.value = true;

    final res = await useCase.getUser();
    data.value = res;

    print('data: ${data.value}');

    isFetching.value = false;
  }

  Future<void> toggleSwitch(bool isBiometricLogin) async {
    isLoadingBio.value = true;

    final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
    final availableBiometrics = await localAuth.getAvailableBiometrics();

    print('canAuthenticate: $canAuthenticateWithBiometrics');
    print('biometric enrolled : $availableBiometrics');

    if (canAuthenticate) {
      try {
        final isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to change biometric login setting',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          ),
        );

        if (isAuthenticated) {
          inject<StorageService>().setIsBiometricLogin(isBiometricLogin);
          this.isBiometricLogin.value = isBiometricLogin;
          update();
        } else {
          // Handle the case where the user cancels the authentication
          print('User cancelled authentication');
        }
      } on PlatformException catch (e) {
        print('Error: $e');
        if (e.code == "auth_in_progress") {
          print("Authentication in progress");
          return;
        }

        errorHandler(e);
      } finally {
        isLoadingBio.value = false;
      }
    }
    else {
      isLoadingBio.value = false;
      Get.bottomSheet(
        BsConfirmation(
          type: BsConfirmationType.danger,
          title: 'Error',
          description: 'error_biometric_not_found'.tr,
          isMultiAction: false,
          positiveButtonOnClick: () {
            Get.back();
          },
        ),
      );
    }
  }

  Future<void> changeLanguage(int id) async {
    isFetching.value = true;
    await Future.delayed(Duration(milliseconds: 500));

    // Update the locale
    switch (id) {
      case 1:
        Get.updateLocale(Locale('id', 'ID')); // Indonesian
        break;
      case 2:
        Get.updateLocale(Locale('en', 'US')); // English
        break;
      default:
        Get.updateLocale(Get.deviceLocale!);
        break;
    }

    isFetching.value = false;
    inject<StorageService>().setSelectedLanguage(id);
  }

  void logout() async {
    useCase.logout();

    await Future.delayed(const Duration(milliseconds: 500));
    hideLoadingOverlay();
    Get.offAllNamed(Routes.LOGIN);
  }
}
