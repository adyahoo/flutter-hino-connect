import 'package:get/get.dart';

import '../../../../presentation/screens/trip/controllers/trip.controller.dart';

class TripControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripController>(
      () => TripController(),
    );
  }
}
