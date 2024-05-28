import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/single_picker/controllers/bs_single_picker.controller.dart';

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

  final isBiometricLogin =
      (inject<StorageService>().getIsBiometricLogin() ?? false).obs;

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

  void toggleSwitch(bool isBiometricLogin) {
    this.isBiometricLogin.value = isBiometricLogin;
    inject<StorageService>().setIsBiometricLogin(isBiometricLogin);
    update();
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
    print('abis Get.updateLocale');
    isFetching.value = false;
    print('abis isFetching false');
    inject<StorageService>().setSelectedLanguage(id);
  }

  void logout() {
    inject<StorageService>().clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
