
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/recent_search_dto.dart';
import 'package:hino_driver_app/domain/core/entities/search_detail_model.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';

class RecentSearchUseCase implements IRecentSearchUseCase{
  const RecentSearchUseCase({required this.dataSource});

  final RecentSearchDataSource dataSource;

  @override
  Future<List<SearchResult>> getRecentSearch() async {
    try {
      final response = await dataSource.getRecentSearches();
      final data = response.data
          .map(
            (e) => SearchResult(
              name: e.name,
              vicinity: e.vicinity,
              lat: e.lat,
              lng: e.lng,
              type: e.type,
            ),
          )
          .toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addRecentSearch(SearchResult data) async {
    try {
      final dto = RecentSearchDto(
        name: data.name,
        vicinity: data.vicinity,
        lat: data.lat,
        lng: data.lng,
        type: data.type,
      );

      await dataSource.addRecentSearch(dto);
    } catch (e) {
      rethrow;
    }
  }

    Future<void> removeRecentSearch(SearchResult data) async {
    try {
      final dto = RecentSearchDto(
        name: data.name,
        vicinity: data.vicinity,
        lat: data.lat,
        lng: data.lng,
        type: data.type,
      );

      await dataSource.removeRecentSearch(dto);
    } catch (e) {
      rethrow;
    }
  }

  //getListSearch
   Future<List<SearchResult>> searchPlaces(String input, double latitude, double longitude) async {
    var rawResults = await dataSource.fetchAutocompleteResults(input, latitude, longitude);
    List<SearchResult> results = [];

    for (var item in rawResults['predictions']) {
      var placeDetailsJson = await dataSource.fetchPlaceDetails(item['place_id']);
      var details = placeDetailsJson['result'];

      if (details != null) {
        var placeDetails = SearchDetailModels.fromJson(details);

        results.add(SearchResult(
          name: placeDetails.name,
          vicinity: placeDetails.vicinity,
          lat: placeDetails.lat,
          lng: placeDetails.lng,
          type: placeDetails.type,
        ));
      }
    }

    return results;
  }
}