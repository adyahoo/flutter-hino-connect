import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/scan_qr.controller.dart';

//gajadi dipake
class ScanQrScreen extends GetView<ScanQrController> {
  const ScanQrScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanQrScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanQrScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
