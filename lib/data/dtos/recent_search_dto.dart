class RecentSearchDto {
  final String name;
  final String vicinity;
  final double lat;
  final double lng;
  final String type;

  RecentSearchDto({
    required this.name,
    required this.vicinity,
    required this.lat,
    required this.lng,
    required this.type,
  });

  factory RecentSearchDto.fromJson(Map<String, dynamic> json) {
    return RecentSearchDto(
      name: json['name'],
      vicinity: json['vicinity'],
      lat: json['lat'],
      lng: json['lng'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'vicinity': this.vicinity,
      'lat': this.lat,
      'lng': this.lng,
      'type': this.type,
    };
  }

  @override
  List<Object> get props => [name, vicinity, lat, lng, type];
}