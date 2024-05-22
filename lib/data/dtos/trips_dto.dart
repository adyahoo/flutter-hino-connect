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

class TripDetailDto extends Equatable {
  const TripDetailDto({
    required this.id,
    required this.origin,
    required this.destination,
    required this.totalPoint,
    required this.penalties,
    required this.createdAt,
  });

  final int id;
  final TripCoordinate origin;
  final TripCoordinate destination;
  final int totalPoint;
  final List<Penalty> penalties;
  final String createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'origin': this.origin.toJson(),
      'destination': this.destination.toJson(),
      'total_point': this.totalPoint,
      'penalties': this.penalties.map((e) => e.toJson()),
      'created_at': this.createdAt,
    };
  }

  factory TripDetailDto.fromJson(Map<String, dynamic> json) {
    return TripDetailDto(
      id: json['id'],
      origin: TripCoordinate.fromJson(json['origin']),
      destination: TripCoordinate.fromJson(json['destination']),
      totalPoint: json['total_point'],
      penalties: (json['penalties'] as Iterable).map((e) => Penalty.fromJson(e)).toList(),
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object> get props => [
        id,
        origin,
        destination,
        totalPoint,
        penalties,
        createdAt,
      ];
}

class TripCoordinate extends Equatable {
  final double lat;
  final double lng;

  const TripCoordinate({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': this.lat,
      'lng': this.lng,
    };
  }

  factory TripCoordinate.fromJson(Map<String, dynamic> json) {
    return TripCoordinate(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  @override
  List<Object> get props => [lat, lng];
}

class Penalty extends Equatable {
  final int id;
  final TripCoordinate coordinate;
  final String type;
  final String? note;
  final String dateTime;

  Penalty({
    required this.id,
    required this.coordinate,
    required this.type,
    required this.note,
    required this.dateTime,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) => Penalty(
        id: json["id"],
        coordinate: TripCoordinate.fromJson(json["coordinate"]),
        type: json["type"],
        note: json["note"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coordinate": coordinate.toJson(),
        "type": type,
        "note": note,
        "date_time": dateTime,
      };

  @override
  List<Object?> get props => [id, coordinate, type, note, dateTime];
}
