import 'package:equatable/equatable.dart';

class PlacesDto extends Equatable {
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  const PlacesDto({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PlacesDto.fromJson(Map<String, dynamic> json) =>
      PlacesDto(
        name: json["name"],
        address: json["address"],
        latitude: json["geometry"]["location"]["lat"],
        longitude: json["geometry"]["location"]["lng"],
      );

  @override
  List<Object?> get props => [name, address, latitude, longitude];
}