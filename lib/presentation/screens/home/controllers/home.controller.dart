import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class HomeController extends GetxController {
  HomeController({
    required this.tripUseCase,
    required this.userUseCase,
  });

  final TripUseCase tripUseCase;
  final UserUseCase userUseCase;

  final todayTrips = Rx<List<TripModel>>([]);
  final user = Rx<UserModel?>(null);
  final isVehicleVerified = false.obs;
  final isFetchingTrip = false.obs;
  final isFetchingUser = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get the argument passed from the previous screen
    if (Get.arguments != null && Get.arguments['refetch'] != null) {
      if (Get.arguments['refetch'] == true) {
        _getData();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    _getData();
  }

  void _getData() {
    _getUser();
    _getVehicle();
    _getTodayTrip();
  }

  void _getTodayTrip() async {
    isFetchingTrip.value = true;

    final res = await tripUseCase.getTodayTripList();
    todayTrips.value = res.data;

    isFetchingTrip.value = false;
  }

  void _getVehicle() async {
    final isVerified = inject<StorageService>().getIsVehicleVerified() ?? false;

    isVehicleVerified.value = isVerified;
  }

  void _getUser() async {
    isFetchingUser.value = true;

    final res = await userUseCase.getUser();
    user.value = res;

    isFetchingUser.value = false;
  }

  void verifyVehicle() async {
    showLoadingOverlay();
    await Future.delayed(const Duration(seconds: 1));

    isVehicleVerified.value = true;
    hideLoadingOverlay();

    _getTodayTrip();
  }
}
