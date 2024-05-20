import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/trip_detail/controllers/trip_detail.controller.dart';

class TripDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TripDetailController>(TripDetailController(tripUseCase: inject()), permanent: true);
  }
}
