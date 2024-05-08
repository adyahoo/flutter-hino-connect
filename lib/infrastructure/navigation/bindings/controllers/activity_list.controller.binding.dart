import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/activity_list/controllers/activity_list.controller.dart';

class ActivityListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityListController>(
      () => ActivityListController(useCase: inject()),
    );
  }
}
