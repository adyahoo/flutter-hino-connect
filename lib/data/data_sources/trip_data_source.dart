part of 'data_source.dart';

class TripDataSource {
  // you should use real http client here later (ex: dio)

  int _getCounterState() {
    int counter = inject<StorageService>().getLoginAttempt() ?? 0;

    if (counter % 2 == 0) {
      counter = 2;
    } else if (counter % 3 == 0) {
      counter = 3;
    } else {
      counter = 1;
    }

    return counter;
  }

  Future<ListPaginationApiResponse<TripDto>> getTripList(Map<TripFilter, dynamic>? filter) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String key = StorageService.TRIPS_ONE_JSON;

      switch (_getCounterState()) {
        case 1:
          key = StorageService.TRIPS_ONE_JSON;
          break;
        case 2:
          key = StorageService.TRIPS_TWO_JSON;
          break;
        case 3:
          key = StorageService.TRIPS_THREE_JSON;
          break;
        default:
          key = StorageService.TRIPS_ONE_JSON;
          break;
      }

      final data = await inject<StorageService>().getJsonData(key);

      final trips = ListPaginationApiResponse<TripDto>.fromJson(
        data!,
        (json) => json
            .map(
              (e) => TripDto.fromJson(e),
            )
            .toList(),
      );

      if (filter != null) {
        final filtered = _getFilteredTrips(trips.data, filter);
        final filteredTrips = trips.copyWith(
          data: filtered,
        );

        return filteredTrips;
      }

      return trips;
    } catch (e) {
      rethrow;
    }
  }

  Future<ListPaginationApiResponse<TripDto>> getTodayTripList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.TRIPS_ONE_JSON);

      final trips = ListPaginationApiResponse<TripDto>.fromJson(
        data!,
        (json) => json
            .map(
              (e) => TripDto.fromJson(e),
            )
            .toList(),
      );

      final today = DateTime.now();
      final formattedToday = DateFormat("yyyy-MM-dd").format(today);

      final todayTrips = trips.data.where((element) {
        final tripDateOrigin = DateFormat("yyy-MM-dd").parse(element.origin.date);
        final formattedDateOrigin = DateFormat("yyy-MM-dd").format(tripDateOrigin);

        final tripDateDestination = DateFormat("yyy-MM-dd").parse(element.destination.date);
        final formattedDateDestination = DateFormat("yyy-MM-dd").format(tripDateDestination);

        return formattedDateOrigin == formattedToday || formattedDateDestination == formattedToday;
      }).toList();

      return trips.copyWith(
        data: todayTrips,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<TripDetailDto> getTripDetail(int id) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.TRIP_DETAILS_ONE_JSON);

      final detailJson = (data!['data'] as Iterable).firstWhere((element) => element['id'] == id);
      final tripDetail = TripDetailDto.fromJson(detailJson);

      return tripDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTripDetail(int id, Penalty penalty) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String key = StorageService.TRIP_DETAILS_ONE_JSON;

      switch (_getCounterState()) {
        case 1:
          key = StorageService.TRIP_DETAILS_ONE_JSON;
          break;
        case 2:
          key = StorageService.TRIP_DETAILS_TWO_JSON;
          break;
        case 3:
          key = StorageService.TRIP_DETAILS_THREE_JSON;
          break;
        default:
          key = StorageService.TRIP_DETAILS_ONE_JSON;
          break;
      }

      final data = await inject<StorageService>().getJsonData(key);
      final details = (data!['data'] as Iterable).map((e) => TripDetailDto.fromJson(e)).toList();

      final editedDetailIndex = details.indexWhere((element) => element.id == id);
      final editedPenaltyIndex = details[editedDetailIndex].penalties.indexWhere((element) => element.id == penalty.id);

      details[editedDetailIndex].penalties[editedPenaltyIndex] = penalty;

      final updatedJson = {
        "data": details.map((e) => e.toJson()).toList(),
      };

      inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_ONE_JSON, updatedJson);
    } catch (e) {
      rethrow;
    }
  }

  _getFilteredTrips(List<TripDto> trips, Map<TripFilter, dynamic> filter) {
    List<TripDto> newTrips = trips;

    if (filter.containsKey(TripFilter.date)) {
      final date = DateFormat("yyyy-MM-dd").format(filter[TripFilter.date] as DateTime);

      newTrips = trips.where((element) {
        final tripDate = DateFormat("yyy-MM-dd").parse(element.createdAt);
        final formattedDate = DateFormat("yyy-MM-dd").format(tripDate);

        return formattedDate == date;
      }).toList();
    }

    return newTrips;
  }
}
