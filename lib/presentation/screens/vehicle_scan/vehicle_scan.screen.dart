import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'controllers/vehicle_scan.controller.dart';

class VehicleScanScreen extends GetView<VehicleScanController> {
  const VehicleScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: controller.qrKey,
            onQRViewCreated: (controller) {
              this.controller.setController(controller);
            },
          ),
        ],
      ),
    );
  }
}
