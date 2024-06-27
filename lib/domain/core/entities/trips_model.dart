import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hino_driver_app/infrastructure/extension.dart';

class TripModel extends Equatable {
  final int id;
  final TripLocationModel origin;
  final TripLocationModel destination;
  final int totalPoint;
  final double totalDistance;
  final String duration;
  final String createdAt;

  TripModel({
    required this.id,
    required this.origin,
    required this.destination,
    required this.totalPoint,
    required this.totalDistance,
    required this.duration,
    required this.createdAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        origin: TripLocationModel.fromJson(json["origin"]),
        destination: TripLocationModel.fromJson(json["destination"]),
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

class TripLocationModel extends Equatable {
  final double lat;
  final double lng;
  final String address;
  final String date;

  TripLocationModel({
    required this.lat,
    required this.lng,
    required this.address,
    required this.date,
  });

  factory TripLocationModel.fromJson(Map<String, dynamic> json) => TripLocationModel(
        lat: json["lat"],
        lng: json["lng"],
        address: json['address'],
        date: json["date"],
      );

  String get formattedDate => this.date.formatDateFromString(Constants.DATE_FORMAT_PENALTY);

  @override
  List<Object> get props => [lat, lng, address, date];
}

class TripDetailModel {
  final int id;
  final LatLng origin;
  final LatLng destination;
  final int totalPoint;
  final List<PenaltyModel> penalties;

  const TripDetailModel({
    required this.id,
    required this.origin,
    required this.destination,
    required this.totalPoint,
    required this.penalties,
  });

  List<String> get penaltiesCoordinates {
    return penalties.map((e) => "${e.coordinate.latitude},${e.coordinate.longitude}").toList();
  }

  @override
  List<Object> get props => [id, origin, destination, totalPoint, penalties];
}

enum PenaltyType { brake, over_speed, acceleration, lateral_accel }

class PenaltyModel {
  final int id;
  final LatLng coordinate;
  final PenaltyType type;
  final String datetime;
  final String? address;
  final String? note;
  final int? point;

  const PenaltyModel({
    required this.id,
    required this.coordinate,
    required this.type,
    required this.datetime,
    required this.point,
    this.address,
    this.note,
  });

  String get category {
    switch (this.type) {
      case PenaltyType.brake:
        return "Harsh Braking";
      case PenaltyType.over_speed:
        return "Over Speeding";
      case PenaltyType.acceleration:
        return "Harsh Acceleration";
      case PenaltyType.lateral_accel:
        return "Hars Lateral Accel";
    }
  }

  String get icon {
    switch (this.type) {
      case PenaltyType.brake:
        return "ic_brake.svg";
      case PenaltyType.over_speed:
        return "ic_over_speed.svg";
      case PenaltyType.acceleration:
        return "ic_accelerate.svg";
      case PenaltyType.lateral_accel:
        return "ic_lateral_accel.svg";
    }
  }

  String get formattedDate => this.datetime.formatDateFromString(Constants.DATE_FORMAT_PENALTY);

  int get penaltyPoint => this.point ?? 0;

  @override
  List<Object?> get props => [
        id,
        coordinate,
        type,
        datetime,
        address,
        note,
        point,
      ];
}
