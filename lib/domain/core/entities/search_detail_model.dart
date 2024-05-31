// models/place_details.dart
class SearchDetailModels {
  final String name;
  final String vicinity;
  final double lat;
  final double lng;
  final String type;

  SearchDetailModels({
    required this.name,
    required this.vicinity,
    required this.lat,
    required this.lng,
    required this.type,
  });

  factory SearchDetailModels.fromJson(Map<String, dynamic> json) {
    var location = json['geometry']['location'];
    var types = json['types'] as List<dynamic>;
    var placeType = types.firstWhere(
      (type) => type == 'gas_station' || type == 'restaurant' || type == 'car_dealer',
      orElse: () => 'unknown',
    );

    return SearchDetailModels(
      name: json['name'],
      vicinity: json['formatted_address'],
      lat: location['lat'],
      lng: location['lng'],
      type: placeType,
    );
  }
}
