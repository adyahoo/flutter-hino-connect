part of 'data_source.dart';

class CountryDataSource {
  Future<List<CountryDto>> getCountries() async {
    try {
      final data = await inject<StorageService>().getJsonData(StorageService.COUNTRIES_JSON);

      return (data!['countries'] as Iterable).map((e) => CountryDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
