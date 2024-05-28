import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _getUser();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getTodayTrip() async {
    isFetchingTrip.value = true;

    final res = await tripUseCase.getTodayTripList();
    todayTrips.value = res.data;

    isFetchingTrip.value = false;
  }

  void _getUser() async {
    final res = await userUseCase.getUser();
    print("sapi user $res");
    user.value = res;
  }

  void verifyVehicle() async {
    showLoadingOverlay();
    await Future.delayed(const Duration(seconds: 1));

    isVehicleVerified.value = true;
    hideLoadingOverlay();

    getTodayTrip();
  }
}
