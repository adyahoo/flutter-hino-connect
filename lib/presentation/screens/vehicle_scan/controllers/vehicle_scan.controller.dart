import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class VehicleScanController extends GetxController {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  late QRViewController controller;

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
    super.onClose();
  }

  void setController(QRViewController controller) {
    this.controller = controller;
  }
}
