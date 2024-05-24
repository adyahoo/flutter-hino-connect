import 'package:equatable/equatable.dart';

class PlacesDto extends Equatable {
  final String? name;
  final String? type;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? phone;

  const PlacesDto({
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  factory PlacesDto.fromJson(Map<String, dynamic> json) =>
      PlacesDto(
        name: json["name"],
        type: json["types"]?.first,
        address: json["vicinity"],
        latitude: json["geometry"]["location"]["lat"],
        longitude: json["geometry"]["location"]["lng"],
        phone: json["international_phone_number"] ?? json["formatted_phone_number"],
      );

  @override
  List<Object?> get props => [name, type, address, latitude, longitude, phone];
}