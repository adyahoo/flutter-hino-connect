import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/vehicle_scan/controllers/vehicle_scan.controller.dart';

class VehicleScanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleScanController>(
      () => VehicleScanController(vehicleScanUseCase: inject()),
    );
  }
}
