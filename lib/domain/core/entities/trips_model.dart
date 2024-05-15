import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripModel {
  final LatLng origin;
  final LatLng destination;
  final List<PenaltyModel> penalties;

  const TripModel({
    required this.origin,
    required this.destination,
    required this.penalties,
  });

  @override
  List<Object> get props => [origin, destination, penalties];
}

enum PenaltyType { brake, over_speed, acceleration, lateral_accel }

class PenaltyModel {
  final int id;
  final LatLng coordinate;
  final PenaltyType type;

  const PenaltyModel({
    required this.id,
    required this.coordinate,
    required this.type,
  });

  @override
  List<Object> get props => [id, coordinate, type];
}
