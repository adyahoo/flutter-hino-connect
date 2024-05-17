import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class HomeController extends GetxController {
  HomeController({
    required this.tripUseCase,
  });

  final TripUseCase tripUseCase;

  final todayTrips = Rx<List<TripModel>>([]);
  final isVehicleVerified = false.obs;
  final isFetchingTrip = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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

  void verifyVehicle() async {
    showLoadingOverlay();
    await Future.delayed(const Duration(seconds: 1));

    isVehicleVerified.value = true;
    hideLoadingOverlay();

    getTodayTrip();
  }
}
