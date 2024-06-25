import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/usecases/splash_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
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
    final permissions = [Permission.location, Permission.camera, Permission.storage, Permission.notification, Permission.microphone];
    if (Platform.isAndroid) {
      final androidInfor = await DeviceInfoPlugin().androidInfo;
      final sdkVersion = androidInfor.version.sdkInt;

      if (sdkVersion >= 34) {
        permissions.add(Permission.scheduleExactAlarm);
      }
    }

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
          // showGetBottomSheet(
          //   BsConfirmation(
          //     type: BsConfirmationType.danger,
          //     title: "permission_permanent_denied_title".tr,
          //     description: "permission_permanent_denied_desc".tr,
          //     positiveTitle: "go_to_setting".tr,
          //     negativeTitle: "back".tr,
          //     positiveButtonOnClick: () {
          //       Get.back();
          //
          //       navigateLogin();
          //       openAppSettings();
          //     },
          //     negativeButtonOnClick: () {
          //       Get.back();
          //     },
          //   ),
          // );
          navigateLogin();
          break;
        default:
          navigateLogin();
          break;
      }
    });
  }

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
      switch (value) {
        case 1:
          Get.updateLocale(Locale('id', 'ID'));
          break;
        case 2:
          Get.updateLocale(Locale('en', 'US'));
          break;
        default:
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
