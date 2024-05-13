import 'package:get/get.dart';

import '../../../../presentation/screens/maps/controllers/maps.controller.dart';

class MapsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
  }
}
