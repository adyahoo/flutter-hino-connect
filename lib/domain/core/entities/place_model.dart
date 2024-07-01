import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String name;
  final String type;
  final String? address;
  final String latitude;
  final String longitude;
  final String? phone;

  const PlaceModel({
    required this.name,
    required this.type,
    this.address,
    required this.latitude,
    required this.longitude,
    this.phone,
  });

  //copy with
  PlaceModel copyWith({
    String? name,
    String? type,
    String? address,
    String? latitude,
    String? longitude,
    String? phone,
  }) {
    return PlaceModel(
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'],
      type: json['type'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [name, type, address, latitude, longitude, phone];
}

class PlaceDetails {
  final String name;
  final String type;
  final String address;
  final String phoneNumber;
  final String position;

  PlaceDetails({
    required this.name,
    required this.type,
    required this.address,
    required this.phoneNumber,
    required this.position,
  });
}
