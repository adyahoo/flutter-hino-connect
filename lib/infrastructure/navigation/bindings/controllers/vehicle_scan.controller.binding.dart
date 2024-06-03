import 'package:get/get.dart';

import '../../../../presentation/screens/vehicle_scan/controllers/vehicle_scan.controller.dart';

class VehicleScanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleScanController>(
      () => VehicleScanController(),
    );
  }
}
