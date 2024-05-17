import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/map_utils.dart';

class TripUseCase implements ITripUseCase {
  const TripUseCase({
    required this.dataSource,
  });

  final TripDataSource dataSource;

  @override
  Future<ListPaginationApiResponse<TripModel>> getTripList() async {
    try {
      final response = await dataSource.getTripList();
      final data = response.data
          .map(
            (e) => TripModel(
              id: e.id,
              origin: TripLocationModel.fromJson(e.origin.toJson()),
              destination: TripLocationModel.fromJson(e.destination.toJson()),
              totalPoint: e.totalPoint,
              totalDistance: e.totalDistance,
              duration: e.duration,
              createdAt: e.createdAt,
            ),
          )
          .toList();

      return ListPaginationApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListPaginationApiResponse<TripModel>> getTodayTripList() async {
    try {
      final response = await dataSource.getTripList();
      final data = response.data
          .map(
            (e) => TripModel(
              id: e.id,
              origin: TripLocationModel.fromJson(e.origin.toJson()),
              destination: TripLocationModel.fromJson(e.destination.toJson()),
              totalPoint: e.totalPoint,
              totalDistance: e.totalDistance,
              duration: e.duration,
              createdAt: e.createdAt,
            ),
          )
          .toList();

      return ListPaginationApiResponse(
        data: data,
        links: response.links,
        meta: response.meta,
      );
    } catch (e) {
      rethrow;
    }
  }
}
