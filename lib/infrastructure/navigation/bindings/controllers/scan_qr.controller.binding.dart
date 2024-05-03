import 'package:get/get.dart';

import '../../../../presentation/screens/scan_qr/controllers/scan_qr.controller.dart';

class ScanQrControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrController>(
      () => ScanQrController(),
    );
  }
}
