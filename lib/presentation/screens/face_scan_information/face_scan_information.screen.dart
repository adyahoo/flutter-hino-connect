import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/face_scan_information.controller.dart';

class FaceScanInformationScreen extends GetView<FaceScanInformationController> {
  const FaceScanInformationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FaceScanInformationScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FaceScanInformationScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
