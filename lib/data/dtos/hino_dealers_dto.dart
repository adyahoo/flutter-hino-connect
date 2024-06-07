import 'package:/equatable/equatable.dart';

class HinoDealerDto extends Equatable {
  final String? id;
  final String? name;
  final String? status;
  final String? province;
  final String? city;
  final String? address;
  final String? latlng;
  final String? facility;

  const HinoDealerDto({
    required this.id,
    required this.name,
    required this.status,
    required this.province,
    required this.city,
    required this.address,
    required this.latlng,
    required this.facility,
  });

  factory HinoDealerDto.fromJson(Map<String, dynamic> json) =>
      HinoDealerDto(
        id: json["id"],
        name: json["dealer_name"],
        status: json["status"],
        province: json["province"],
        city: json["city"],
        address: json["address"],
        latlng: json["latlng"],
        facility: json["facility"],
      );

  @override
  List<Object?> get props => [id, name, status, province, city, address, latlng, facility];
}