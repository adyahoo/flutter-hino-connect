import 'package:get/get.dart';
import 'package:hino_driver_app/presentation/screens/main_tab/controllers/main_tab.controller.dart';

class MainTabControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(
      () => MainTabController(),
    );
  }
}
