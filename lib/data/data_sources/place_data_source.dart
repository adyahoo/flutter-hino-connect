part of 'data_source.dart';

class PlaceDataSource {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

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
}