import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

class ScanQrController extends GetxController {
  final qrText = ''.obs;
  QRViewController? qrViewController;

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        qrViewController?.pauseCamera(); // Pause the camera when a code is scanned
        Get.bottomSheet(
          SuccessBottomSheet(
            type: BSDescriptionType.success,
            title: 'Kode berhasil dibaca',
            description: scanData.code!,
          ),
        );
        
        Future.delayed(Duration(seconds: 3), () {
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();  // Close the bottom sheet after 3 seconds
            Get.offAllNamed(Routes.MAIN_TAB, arguments: {'isVehicleVerified': true}); // Navigate to the home screen with argument
          }
        });
      }
    }, onError: (error) {
      print('Error scanning QR code: $error');
    });
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
