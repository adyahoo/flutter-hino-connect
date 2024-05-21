import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

import '../../../../infrastructure/di.dart';

class ProfileController extends GetxController {

  ProfileController({required this.useCase});

  final UserUseCase useCase;

  final data = Rx<UserModel>(UserModel(
    id: '',
    name: '',
    email: '',
    role: '',
    status: '',
    profilePic: '',
    score: '',
    phoneCode: '',
    phoneNumber: '',
    createdAt: '',
    updatedAt: '',
  ));
  final isFetching = true.obs;

  var isBiometricLogin = (inject<StorageService>().getIsBiometricLogin() ?? false).obs;

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
    data.value = res.data;
    print('data: ${data.value}');

    isFetching.value = false;
  }

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

  void logout(){
    inject<StorageService>().clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}