import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/trip_list/controllers/trip_list.controller.dart';

class TripListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripListController>(
      () => TripListController(useCase: inject()),
    );
  }
}
