class SearchResult {
  final String name;
  final String vicinity;
  final double lat;
  final double lng;
  final String type;

  SearchResult({
    required this.name,
    required this.vicinity,
    required this.lat,
    required this.lng,
    this.type = 'place',
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      name: json['name'],
      vicinity: json['vicinity'],
      lat: json['lat'],
      lng: json['lng'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'vicinity': vicinity,
      'lat': lat,
      'lng': lng,
      'type': type,
    };
  }
}

