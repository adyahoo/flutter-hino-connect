import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';

import '../../../../presentation/screens/emergency_contact_list/controllers/emergency_contact_list.controller.dart';

class EmergencyContactListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyContactListController>(
      () => EmergencyContactListController(useCase: inject()),
    );
  }
}
