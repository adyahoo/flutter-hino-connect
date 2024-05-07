import 'package:get/get.dart';

import '../../../../presentation/screens/face_scan_information/controllers/face_scan_information.controller.dart';

class FaceScanInformationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceScanInformationController>(
      () => FaceScanInformationController(),
    );
  }
}
