import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';

class TripListController extends GetxController {
  TripListController({required this.useCase});

  final TripUseCase useCase;

  final trips = Rx<List<TripModel>>([]);
  final isFetching = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTripList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTripList() async {
    isFetching.value = true;

    final res = await useCase.getTripList();
    trips.value = res.data;

    isFetching.value = false;
  }
}
