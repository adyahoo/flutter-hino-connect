import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _checkPermission();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkPermission() async {
    final permissions = [Permission.location];

    final result = await permissions.request();
    print("sapi permission: $result");

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

  void _openAppSetting(){

  }

  void navigateLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (inject<StorageService>().getToken() != null)
        Get.offNamed(Routes.MAIN_TAB);
      else
        Get.offNamed(Routes.LOGIN);
    });
  }
}
