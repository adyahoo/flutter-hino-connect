import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/trips_dto.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/presentation/screens/trip_list/controllers/trip_list.controller.dart';

class TripUseCase implements ITripUseCase {
  const TripUseCase({
    required this.dataSource,
  });

  final TripDataSource dataSource;

  @override
  Future<ListPaginationApiResponse<TripModel>> getTripList(Map<TripFilter, dynamic>? filter) async {
    try {
      final response = await dataSource.getTripList(filter);
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
      final response = await dataSource.getTripList(null);
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
  Future<TripDetailModel> getTripDetail(int id) async {
    try {
      final response = await dataSource.getTripDetail(id);
      final data = response;

      return TripDetailModel(
        id: data.id,
        origin: LatLng(data.origin.lat, data.origin.lng),
        destination: LatLng(data.destination.lat, data.destination.lng),
        penalties: data.penalties
            .map(
              (e) => PenaltyModel(
                id: e.id,
                coordinate: LatLng(e.coordinate.lat, e.coordinate.lng),
                type: PenaltyType.values.firstWhere((element) {
                  return element.name == e.type;
                }),
                datetime: e.dateTime,
                note: e.note,
              ),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTripDetail(int id, PenaltyModel penalty) async {
    try {
      final dto = Penalty(
        id: penalty.id,
        coordinate: TripCoordinate(lat: penalty.coordinate.latitude, lng: penalty.coordinate.longitude),
        type: penalty.type.name,
        note: penalty.note,
        dateTime: penalty.datetime,
      );

      await dataSource.updateTripDetail(id, dto);
    } catch (e) {
      rethrow;
    }
  }
}
