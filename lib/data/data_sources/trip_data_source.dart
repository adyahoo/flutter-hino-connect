part of 'data_source.dart';

class TripDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListPaginationApiResponse<TripDto>> getTripList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trips.json');
      final data = await json.decode(response);

      return ListPaginationApiResponse.fromJson(
        data,
        (json) => json
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
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/trip_details.json');
      final data = await json.decode(response);

      final detailJson = (data['data'] as Iterable).firstWhere((element) => element['id'] == id);
      final tripDetail = TripDetailDto.fromJson(detailJson);
      print("sapi json $detailJson");

      return tripDetail;
    } catch (e) {
      rethrow;
    }
  }
}
