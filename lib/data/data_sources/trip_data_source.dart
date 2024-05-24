part of 'data_source.dart';

class TripDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListPaginationApiResponse<TripDto>> getTripList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.TRIPS_JSON);

      return ListPaginationApiResponse.fromJson(
        data!,
            (json) =>
            json
                .map(
                  (e) => TripDto.fromJson(e),
            )
                .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<TripDetailDto> getTripDetail(int id) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.TRIP_DETAILS_JSON);

      print("sapi detail ${data}");
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
      final data = await inject<StorageService>().getJsonData(StorageService.TRIP_DETAILS_JSON);
      final details = (data!['data'] as Iterable).map((e) => TripDetailDto.fromJson(e)).toList();

      final editedDetailIndex = details.indexWhere((element) => element.id == id);
      final editedPenaltyIndex = details[editedDetailIndex].penalties.indexWhere((element) => element.id == penalty.id);

      details[editedDetailIndex].penalties[editedPenaltyIndex] = penalty;

      final updatedJson = {
        "data": details.map((e) => e.toJson()).toList(),
      };

      inject<StorageService>().setJsonData(StorageService.TRIP_DETAILS_JSON, updatedJson);
    } catch (e) {
      rethrow;
    }
  }
}
