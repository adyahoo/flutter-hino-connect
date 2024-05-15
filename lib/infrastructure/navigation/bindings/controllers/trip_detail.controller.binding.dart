import 'package:get/get.dart';

import '../../../../presentation/screens/trip_detail/controllers/trip_detail.controller.dart';

class TripDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripDetailController>(
      () => TripDetailController(),
    );
  }
}
