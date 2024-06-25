import 'package:equatable/equatable.dart';

class HinoDealerDto extends Equatable {
  final String? id;
  final String? name;
  final String? status;
  final String? province;
  final String? city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? grade;
  final String? facility;

  const HinoDealerDto({
    required this.id,
    required this.name,
    required this.status,
    required this.province,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.grade,
    required this.facility,
  });

    @override
  String toString() {
    return 'HinoDealerDto{id: $id, name: $name, status: $status, province: $province, city: $city, address: $address, latitude: $latitude, longitude: $longitude, facility: $facility}';
  }

  factory HinoDealerDto.fromJson(Map<String, dynamic> json) {
    double? latitude;
    double? longitude;

    if (json["latlng"] != null) {
      var latlng = json["latlng"].split(',');
      if (latlng.length == 2) {
        latitude = double.tryParse(latlng[0].trim());
        longitude = double.tryParse(latlng[1].trim());

        if (latitude == null || longitude == null) {
          print('Error parsing latlng: ${json["latlng"]}');
        }
      } else {
        print('Invalid latlng format: ${json["latlng"]}');
      }
    } else {
      print('latlng is null in JSON');
    }

    return HinoDealerDto(
      id: json["no"],
      name: json["dealer_name"],
      status: json["status"],
      province: json["province"],
      city: json["city"],
      address: json["address"],
      latitude: latitude,
      longitude: longitude,
      grade: json["grade"],
      facility: json["facility"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        province,
        city,
        address,
        latitude,
        longitude,
        grade,
        facility
      ];
}
