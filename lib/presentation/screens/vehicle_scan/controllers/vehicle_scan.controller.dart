import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _panelController = PanelController();

class VehicleScanController extends GetxController {
  late QRViewController controller;
  late Timer timer;

  final qrKey = GlobalKey(debugLabel: 'QR');

  final panelController = _panelController;

  final result = Rx<Barcode?>(null);
  final counter = Duration(seconds: 3).obs;

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
    controller.dispose();
    if (timer.isActive) {
      timer.cancel();
    }

    super.onClose();
  }

  void setController(QRViewController controller) {
    this.controller = controller;

    _listenQr();
  }

  void _listenQr() {
    controller.scannedDataStream.listen((event) {
      result.value = event;
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

    if(counter.value.inSeconds == 0) {
      Get.offAllNamed(Routes.MAIN_TAB);
    }
  }
}
