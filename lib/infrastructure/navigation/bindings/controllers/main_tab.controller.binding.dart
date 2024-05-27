import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/activity_list/controllers/activity_list.controller.dart';
import 'package:hino_driver_app/presentation/screens/event_list/controllers/event_list.controller.dart';
import 'package:hino_driver_app/presentation/screens/home/controllers/home.controller.dart';
import 'package:hino_driver_app/presentation/screens/main_tab/controllers/main_tab.controller.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';

class MainTabControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(() => MainTabController());
    Get.lazyPut<HomeController>(() => HomeController(tripUseCase: inject(), userUseCase: inject()));
    Get.lazyPut<MapsController>(() => MapsController(useCase: inject()));
    Get.lazyPut<ActivityListController>(() => ActivityListController(useCase: inject()));
    Get.lazyPut<EventListController>(() => EventListController(useCase: inject()));
  }
}
