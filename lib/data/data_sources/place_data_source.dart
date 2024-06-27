part of 'data_source.dart';

class PlaceDataSource {
  final String baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  final double cacheRadius = 400;

  Future<PlacesApiResponse> getPlaceList(
      double lat, double long, String type) async {
    final LatLng venueLocation = Constants.venueLocation;
    final distance = calculateDistance(
        lat, long, venueLocation.latitude, venueLocation.longitude);

    // Check if it's within the cache radius
    if (distance <= cacheRadius &&
        (type != 'car_dealer' && type != 'service_center')) {
      print('within venue location radius');
      // Check if cached data is available
      final cachedPlacesJson = await inject<StorageService>()
          .getJsonData(StorageService.PLACE_NEAR_VENUE_JSON);
      print('cachedPlacesJson: $cachedPlacesJson');
      if (cachedPlacesJson?['results'].length != 0) {
        print('Using cached response');
        if (cachedPlacesJson != null) {
          return PlacesApiResponse.fromJson(cachedPlacesJson);
        }
      }
    }

    print('Fetching new data');
    // Fetch data from the API
    final apiKey = Constants.MAP_API_KEY;
    // final apiUrl = '$baseUrl?location=$lat,$long&radius=400&type=$type&key=$apiKey';
    final apiUrl =
        '$baseUrl?location=$lat,$long&radius=400&type=$type&key=$apiKey&fields=address_component,geometry,formatted_address,name,types';
    final response = await http.get(Uri.parse(apiUrl));

    print('Response now perlu: ${response.body}');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      // Cache the fetched data if it's within the cache radius
      if (distance <= cacheRadius &&
          (type != 'car_dealer' && type != 'service_center')) {
        inject<StorageService>().setJsonData(
          StorageService.PLACE_NEAR_VENUE_JSON,
          decodedData,
        );
      }

      return PlacesApiResponse.fromJson(decodedData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
