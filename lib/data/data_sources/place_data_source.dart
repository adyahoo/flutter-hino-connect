// part of 'data_source.dart';

// class PlaceDataSource {
//   final String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

//   Future<PlacesApiResponse> fetchNearbyPlaces(double lat, double lng, String type) async {
//     final apiKey = Constants.MAP_API_KEY;
//     final apiUrl = '$baseUrl?location=$lat,$lng&radius=400&type=$type&key=$apiKey';
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final decodedData = json.decode(response.body);
//       print('decoded DATA: ' + const JsonEncoder.withIndent('  ').convert(decodedData));
//       return PlacesApiResponse.fromJson(decodedData);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

  
// }

part of 'data_source.dart';

class PlaceDataSource {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

  PlacesApiResponse? _cachedResponse;
  double? _cachedLat;
  double? _cachedLng;
  final double _cacheRadius = 500; // 500 meters

  Future<PlacesApiResponse> fetchNearbyPlaces(double lat, double lng, String type) async {
    final apiKey = Constants.MAP_API_KEY;
    final apiUrl = '$baseUrl?location=$lat,$lng&radius=400&type=$type&key=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print('decoded DATA: ' + const JsonEncoder.withIndent('  ').convert(decodedData));
      return PlacesApiResponse.fromJson(decodedData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<PlacesApiResponse> fetchPlacesWithCache(double lat, double lng, String type) async {
    // Check if the cached location is within the cache radius
    if (_cachedResponse != null && _cachedLat != null && _cachedLng != null) {
      double distance = calculateDistance(lat, lng, _cachedLat!, _cachedLng!);
      if (distance <= _cacheRadius) {
        print('Using cached response');
        return _cachedResponse!;
      }
    }

    // Fetch new data from the API
    final apiKey = Constants.MAP_API_KEY;
    final apiUrl = '$baseUrl?location=$lat,$lng&radius=400&type=$type&key=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print('decoded DATA: ' + const JsonEncoder.withIndent('  ').convert(decodedData));
      _cachedResponse = PlacesApiResponse.fromJson(decodedData);
      _cachedLat = lat;
      _cachedLng = lng;
      return _cachedResponse!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
