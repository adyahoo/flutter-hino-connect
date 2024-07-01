import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/extension.dart';

enum TripFilter { date }

class TripListController extends GetxController {
  TripListController({required this.useCase});

  final TripUseCase useCase;

  final filterEditingController = TextEditingController().obs;
  final trips = Rx<Map<String, List<TripModel>>>({});
  final isFetching = false.obs;
  final filterApplied = false.obs;

  DateTime date = DateTime.now();
  Map<TripFilter, dynamic>? _filter = null;

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

    final res = await useCase.getTripList(_filter);
    final groupedItem = _groupByDate(res.data);

    trips.value = groupedItem;

    isFetching.value = false;
  }

  Map<String, List<TripModel>> _groupByDate(List<TripModel> data) {
    Map<String, List<TripModel>> groupedItems = {};

    data.forEach((e) {
      String formattedDate = e.createdAt.formatDateFromString(Constants.DATE_FORMAT_TRIP);

      if (groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate]!.add(e);
      } else {
        groupedItems[formattedDate] = [e];
      }
    });

    return groupedItems;
  }

  void setDate(DateTime? value) {
    if (value != null) {
      date = value;

      filterEditingController.value.text = value.formatDate(Constants.DATE_FORMAT_TRIP);
      _filter = {
        ...?_filter,
        TripFilter.date: date,
      };
      filterApplied.value = true;

      getTripList();
    }
  }

  void clearFilter() {
    _filter = null;
    filterEditingController.value.clear();
    filterApplied.value = false; // Reset filter applied flag

    getTripList();
  }
}
