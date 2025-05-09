import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class MainTabController extends GetxController {
  final activeIndex = 0.obs;
  final activeScreen = Rx<Widget>(HomeScreen());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTapMenu(int index) {
    if (index != 2) {
      activeIndex.value = index;

      switch (index) {
        case 0:
          activeScreen.value = HomeScreen();
          break;
        case 1:
          activeScreen.value = MapsScreen();
          break;
        case 3:
          activeScreen.value = LogScreen();
          break;
        case 4:
          showGetBottomSheet(BsSos(), canExpand: true);
          break;
      }
    }
  }

  void navigateScanQR() {
    Get.toNamed(Routes.FACE_SCAN_INFORMATION);
  }
}
