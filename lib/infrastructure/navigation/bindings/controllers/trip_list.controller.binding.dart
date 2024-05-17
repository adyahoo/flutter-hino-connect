import 'package:get/get.dart';

import '../../../../presentation/screens/trip_list/controllers/trip_list.controller.dart';

class TripListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripListController>(
      () => TripListController(),
    );
  }
}
