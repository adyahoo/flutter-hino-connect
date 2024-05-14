import 'package:equatable/equatable.dart';
import 'package:hino_driver_app/data/dtos/places_dto.dart';

class PlacesApiResponse extends Equatable {
  final List<PlacesDto> results;

  const PlacesApiResponse({
    required this.results,
  });

  // factory PlacesApiResponse.fromJson(List<dynamic> json) {
  //   return PlacesApiResponse(
  //     results: json.map((e) => PlacesDto.fromJson(e as Map<String, dynamic>)).toList(),
  //   );
  // }

  factory PlacesApiResponse.fromJson(Map<String, dynamic> json) {
  return PlacesApiResponse(
    results: (json['results'] as List<dynamic>)
        .map((e) => PlacesDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

  @override
  List<Object> get props => [results];
}