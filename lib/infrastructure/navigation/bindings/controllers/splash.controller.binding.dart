import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/splash/controllers/splash.controller.dart';

class SplashControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(useCase: inject()),
    );
  }
}
