import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String name;
  final String? address;
  final String latitude;
  final String longitude;

  const PlaceModel({
    required this.name,
    this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [name, address, latitude, longitude];
}