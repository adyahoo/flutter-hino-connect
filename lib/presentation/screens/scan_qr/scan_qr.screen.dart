import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'controllers/scan_qr.controller.dart';

class ScanQrScreen extends GetView<ScanQrController> {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove the shadow
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: controller.onQRViewCreated,
          ),
          Center(
            child: Icon(
              Iconsax.scan,
              size: 250,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
