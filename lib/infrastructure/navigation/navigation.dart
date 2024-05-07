import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.MAIN_TAB,
      page: () => const MainTabScreen(),
      binding: MainTabControllerBinding(),
    ),
    GetPage(
      name: Routes.SCAN_QR,
      page: () => const ScanQrScreen(),
      binding: ScanQrControllerBinding(),
    ),
    GetPage(
      name: Routes.FACE_RECOGNITION,
      page: () => const FaceRecognitionScreen(),
      binding: FaceRecognitionControllerBinding(),
    ),
    GetPage(
      name: Routes.FACE_SCAN_INFORMATION,
      page: () => const FaceScanInformationScreen(),
      binding: FaceScanInformationControllerBinding(),
    ),
  ];
}
