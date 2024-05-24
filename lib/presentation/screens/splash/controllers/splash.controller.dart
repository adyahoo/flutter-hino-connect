import 'dart:ui';

import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/usecases/splash_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  SplashController({required this.useCase});

  final SplashUseCase useCase;

  final isLoading = true.obs;

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _checkPermission();
    _changeLanguage();
    _checkLocalJson();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkPermission() async {
    final permissions = [Permission.location, Permission.camera, Permission.storage];

    final result = await permissions.request();

    result.forEach((key, value) {
      switch (value) {
        case PermissionStatus.denied:
          navigateLogin();
          break;
        case PermissionStatus.granted:
          navigateLogin();
          break;
        case PermissionStatus.restricted:
          navigateLogin();
          break;
        case PermissionStatus.permanentlyDenied:
          navigateLogin();
          break;
        default:
          navigateLogin();
          break;
      }
    });
  }

  void _openAppSetting() {}

  void navigateLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (inject<StorageService>().getToken() != null)
        Get.offNamed(Routes.MAIN_TAB);
      else
        Get.offNamed(Routes.LOGIN);
    });
  }

  void _changeLanguage() {
    Future.value(inject<StorageService>().getSelectedLanguage()).then((value) {
      print("check language: $value");
      switch (value) {
        case 1:
          print('masuk case 1');
          Get.updateLocale(Locale('id', 'ID'));
          break;
        case 2:
          print('masuk case 2');
          Get.updateLocale(Locale('en', 'US'));
          break;
        default:
          print('masuk default');
          break;
      }
    });
  }
    
  void _checkLocalJson() async {
    final jsonData = await inject<StorageService>().getJsonData(StorageService.USERS_JSON);

    if (jsonData != null) {
      return;
    }

    useCase.writeLocalJson();
  }
}

