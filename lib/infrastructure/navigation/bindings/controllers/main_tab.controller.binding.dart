import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/activity_list/controllers/activity_list.controller.dart';
import 'package:hino_driver_app/presentation/screens/event_list/controllers/event_list.controller.dart';
import 'package:hino_driver_app/presentation/screens/home/controllers/home.controller.dart';
import 'package:hino_driver_app/presentation/screens/main_tab/controllers/main_tab.controller.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/screens/trip/controllers/trip.controller.dart';

class MainTabControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(() => MainTabController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TripController>(() => TripController());
    Get.lazyPut<ActivityListController>(() => ActivityListController(useCase: inject()));

    Get.lazyPut<EventListController>(() => EventListController(useCase: inject()));
    Get.lazyPut<ProfileController>(() => ProfileController(useCase: inject()));

  }
}
