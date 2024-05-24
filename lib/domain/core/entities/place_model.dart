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

  @override
  List<Object?> get props => [name, type, address, latitude, longitude, phone];
}