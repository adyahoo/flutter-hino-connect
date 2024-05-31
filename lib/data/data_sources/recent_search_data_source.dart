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

  Future<Map<String, dynamic>> fetchAutocompleteResults(
      String input, double latitude, double longitude) async {
    String apiKey = Constants.MAP_API_KEY;
    final type = "gas_station|restaurant|car_dealer";
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input'
        '&key=$apiKey'
        '&types=$type'
        '&components=country:ID'
        '&location=$latitude,$longitude'
        '&radius=400';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load autocomplete results');
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    String apiKey = Constants.MAP_API_KEY;
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&fields=address_component,geometry,formatted_address,name,types';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
