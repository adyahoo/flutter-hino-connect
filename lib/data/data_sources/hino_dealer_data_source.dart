part of 'data_source.dart';

class HinoDealerDataSource {
  Future<ListApiResponse<HinoDealerDto>> getHinoDealers() async {
    try {
      final data = await inject<StorageService>().getJsonData(StorageService.HINO_DEALERS_JSON);

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
