part of 'data_source.dart';

class TripDataSource {
  // you should use real http client here later (ex: dio)

  int _getCounterState() {
    int counter = inject<StorageService>().getLoginAttempt() ?? 0;

    if (counter % 3 == 2) {
      counter = 2;
    } else if (counter % 3 == 1) {
      counter = 1;
    } else {
      counter = 3;
    }

    return counter;
  }

  String detailKey = StorageService.TRIP_DETAIL_HINO_1_JSON;
  String tripKey = StorageService.TRIP_HINO_1_JSON;

  void _setJsonKey() {
    switch (_getCounterState()) {
      case 1:
        tripKey = StorageService.TRIP_HINO_1_JSON;
        detailKey = StorageService.TRIP_DETAIL_HINO_1_JSON;
        break;
      case 2:
        tripKey = StorageService.TRIP_HINO_2_JSON;
        detailKey = StorageService.TRIP_DETAIL_HINO_2_JSON;
        break;
      case 3:
        tripKey = StorageService.TRIP_HINO_3_JSON;
        detailKey = StorageService.TRIP_DETAIL_HINO_3_JSON;
        break;
      default:
        tripKey = StorageService.TRIP_HINO_1_JSON;
        detailKey = StorageService.TRIP_DETAIL_HINO_1_JSON;
        break;
    }

    print("sapi trip key $tripKey");
  }

  Future<ListPaginationApiResponse<TripDto>> getTripList(Map<TripFilter, dynamic>? filter) async {
    try {
      _setJsonKey();
      await Future.delayed(const Duration(milliseconds: 500));

      final data = await inject<StorageService>().getJsonData(tripKey);

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
      _setJsonKey();
      await Future.delayed(const Duration(milliseconds: 500));

      final data = await inject<StorageService>().getJsonData(tripKey);

      final trips = ListPaginationApiResponse<TripDto>.fromJson(
        data!,
        (json) => json
            .map(
              (e) => TripDto.fromJson(e),
            )
            .toList(),
      );

      final today = DateTime.now();
      final todayFormat = "yyyy-MM-dd";
      final tripFormat = "yyy-MM-dd";

      final formattedToday = today.formatDate(todayFormat);

      final todayTrips = trips.data.where((element) {
        final formattedDateOrigin = element.origin.date.formatDateFromString(tripFormat, sourceFormat: tripFormat);
        final formattedDateDestination = element.destination.date.formatDateFromString(tripFormat, sourceFormat: tripFormat);

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
      _setJsonKey();
      await Future.delayed(const Duration(milliseconds: 500));

      final data = await inject<StorageService>().getJsonData(detailKey);

      final detailJson = (data!['data'] as Iterable).firstWhere((element) => element['id'] == id);
      final tripDetail = TripDetailDto.fromJson(detailJson);

      return tripDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTripDetail(int id, Penalty penalty) async {
    try {
      _setJsonKey();
      await Future.delayed(const Duration(milliseconds: 500));

      final data = await inject<StorageService>().getJsonData(detailKey);
      final details = (data!['data'] as Iterable).map((e) => TripDetailDto.fromJson(e)).toList();

      final editedDetailIndex = details.indexWhere((element) => element.id == id);
      final editedPenaltyIndex = details[editedDetailIndex].penalties.indexWhere((element) => element.id == penalty.id);

      details[editedDetailIndex].penalties[editedPenaltyIndex] = penalty;

      final updatedJson = {
        "data": details.map((e) => e.toJson()).toList(),
      };

      inject<StorageService>().setJsonData(detailKey, updatedJson);
    } catch (e) {
      rethrow;
    }
  }

  _getFilteredTrips(List<TripDto> trips, Map<TripFilter, dynamic> filter) {
    List<TripDto> newTrips = trips;

    if (filter.containsKey(TripFilter.date)) {
      final date = (filter[TripFilter.date] as DateTime).formatDate("yyyy-MM-dd");

      newTrips = trips.where((element) {
        final formattedDate = element.createdAt.formatDateFromString("yyy-MM-dd", sourceFormat: "yyy-MM-dd");

        return formattedDate == date;
      }).toList();
    }

    return newTrips;
  }
}
