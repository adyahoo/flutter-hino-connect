import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/event_list/controllers/event_list.controller.dart';

class EventListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventListController>(
      () => EventListController(useCase: inject()),
    );
  }
}
