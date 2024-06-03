part of 'data_source.dart';

class RecentSearchDataSource {
  Future<ListApiResponse<RecentSearchDto>> getRecentSearches() async {
    try {
      final data = await inject<StorageService>()
          .getJsonData(StorageService.RECENT_SEARCHES_JSON);

      print('Fetched JSON: $data');

      return ListApiResponse.fromJson(
        data!,
        (json) => json
            .map(
              (e) => RecentSearchDto.fromJson(e),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addRecentSearch(RecentSearchDto newData) async {
    try {
      final data = await inject<StorageService>()
          .getJsonData(StorageService.RECENT_SEARCHES_JSON);

      // Initialize an empty list if data is null
      List<dynamic> currentData = data?['data'] ?? [];

      // Check if a search with the same name and address already exists
      if (!currentData.any((element) =>
          element['name'] == newData.name &&
          element['vicinity'] == newData.vicinity)) {
        // If the list length is 5, remove the first element
        if (currentData.length == 5) {
          currentData.removeAt(0);
        }

        // Add the new search to the list
        currentData.add(newData.toJson());

        // Save the updated list back to storage
        inject<StorageService>().setJsonData(
            StorageService.RECENT_SEARCHES_JSON, {"data": currentData});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeRecentSearch(RecentSearchDto searchToRemove) async {
    try {
      final data = await inject<StorageService>()
          .getJsonData(StorageService.RECENT_SEARCHES_JSON);

      // Initialize an empty list if data is null
      List<dynamic> currentData = data?['data'] ?? [];

      print('Current data: $currentData');
      print('Search to remove: $searchToRemove');

      // Remove the search from the list
      currentData.removeWhere((element) =>
          element['name'] == searchToRemove.name &&
          element['vicinity'] == searchToRemove.vicinity);

      print('Updated data: $currentData');

      // Save the updated list back to storage
      inject<StorageService>().setJsonData(
          StorageService.RECENT_SEARCHES_JSON, {"data": currentData});
    } catch (e) {
      rethrow;
    }
  }
}
