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

  @override
  List<Object> get props => [name, vicinity, lat, lng, type];
}

