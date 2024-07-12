import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/usecases/vehicle_scan_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';

final _panelController = PanelController();

class VehicleScanController extends GetxController {
  VehicleScanController({required this.vehicleScanUseCase});

  late QRViewController qrController;
  late Timer timer;

  final VehicleScanUseCase vehicleScanUseCase;
  final qrKey = GlobalKey(debugLabel: 'QR');
  final panelController = _panelController;

  final result = Rx<Barcode?>(null);
  final counter = Duration(seconds: 3).obs;

  @override
  void onClose() {
    result.value = null;
    qrController.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
    super.onClose();
  }

  void setController(QRViewController controller) {
    qrController = controller;

    if (Platform.isAndroid) {
      controller.pauseCamera();
      Future.delayed(Duration(milliseconds: 500), () {
        // controller.resumeCamera();
        // Get.snackbar('Camera Resumed', 'The camera has been resumed successfully.');
      });
    } else {
      controller.resumeCamera();
    }

    // Get.snackbar('QRView Created', 'QRView has been created successfully.');
    _listenQr();
  }

  void _listenQr() {
    qrController.scannedDataStream.listen((event) async {
      result.value = event;
      qrController.pauseCamera();
      await vehicleScanUseCase.verifyVehicle();
      _startRedirectTimer();
    });
  }

  void _startRedirectTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _setTimer();
      },
    );
  }

  void _setTimer() {
    counter.value = Duration(seconds: counter.value.inSeconds - 1);

    if (counter.value.inSeconds == 0) {
      Get.offAllNamed(Routes.MAIN_TAB, arguments: {'refetch': true});
    }
  }
}
