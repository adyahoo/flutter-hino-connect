import 'package:equatable/equatable.dart';

class TripDto extends Equatable {
  final int id;
  final TripLocationDto origin;
  final TripLocationDto destination;
  final int totalPoint;
  final int totalDistance;
  final String duration;
  final String createdAt;

  TripDto({
    required this.id,
    required this.origin,
    required this.destination,
    required this.totalPoint,
    required this.totalDistance,
    required this.duration,
    required this.createdAt,
  });

  factory TripDto.fromJson(Map<String, dynamic> json) => TripDto(
        id: json["id"],
        origin: TripLocationDto.fromJson(json["origin"]),
        destination: TripLocationDto.fromJson(json["destination"]),
        totalPoint: json["total_point"],
        totalDistance: json["total_distance"],
        duration: json["duration"],
        createdAt: json["created_at"],
      );

  @override
  List<Object> get props => [
        id,
        origin,
        destination,
        totalPoint,
        totalDistance,
        duration,
        createdAt,
      ];
}

class TripLocationDto extends Equatable {
  final double lat;
  final double lng;
  final String address;
  final String date;

  TripLocationDto({
    required this.lat,
    required this.lng,
    required this.address,
    required this.date,
  });

  factory TripLocationDto.fromJson(Map<String, dynamic> json) => TripLocationDto(
        lat: json["lat"],
        lng: json["lng"],
        address: json["address"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "address": address,
        "date": date,
      };

  @override
  List<Object> get props => [lat, lng, address, date];
}
