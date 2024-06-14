part of 'data_source.dart';

class HinoDealerDataSource {
  Future<ListApiResponse<HinoDealerDto>> getHinoDealers() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>()
          .getJsonData(StorageService.HINO_DEALERS_JSON);

      print('Fetched JSON: $data');

      return ListApiResponse.fromJson(
        data ?? {},
        (json) => json
            .map(
              (e) => HinoDealerDto.fromJson(e),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
