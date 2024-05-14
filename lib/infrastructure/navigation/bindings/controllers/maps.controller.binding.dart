import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/maps/controllers/maps.controller.dart';

class MapsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(useCase: inject()),
    );
  }
}
