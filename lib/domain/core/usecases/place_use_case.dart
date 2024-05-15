import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/place_api_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';

class PlaceUseCase {
  const PlaceUseCase({required this.dataSource});

  final PlaceDataSource dataSource;

  Future<List<PlaceModel>> getPlaceList(
      double lat, double long, String type) async {
    try {
      final response = await dataSource.fetchNearbyPlaces(lat, long, type);
      // final data = response.results
      //     .map(
      //       (e) => PlaceModel(
      //         id: e.id,
      //         name: e.name,
      //         address: e.address,
      //         longitude: e.longitude,
      //         latitude: e.latitude,
      //       ),
      //     )
      //     .toList();

      print('response $response');

      final data = response.results
          .where((e) =>
              e.name != null && e.longitude != null && e.latitude != null)
          .map(
            // (e) => PlaceModel(
            //   name: e.name!,
            //   address: e.address,
            //   longitude: e.longitude!.toString(),
            //   latitude: e.latitude!.toString(),
            // ),
            (e) => PlaceModel(
              name: e.name!,
              type: e.type!,
              address: e.address,
              latitude: e.latitude!.toString(),
              longitude: e.longitude!.toString(),
              phone: e.phone ?? '-',
            ),
          )
          .toList();
      print("\n data $data");

      return data;
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }
}
