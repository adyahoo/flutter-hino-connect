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
}
