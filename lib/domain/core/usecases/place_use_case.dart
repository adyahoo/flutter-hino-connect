import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';

class PlaceUseCase {
  const PlaceUseCase({required this.dataSource, required this.hinoDataSource});

  final PlaceDataSource dataSource;
  final HinoDealerDataSource hinoDataSource;

  Future<List<PlaceModel>> getPlaceList(
    double lat,
    double long,
    String type,
  ) async {
    try {
      if (type == 'car_dealer') {
        final hinoResponse = await hinoDataSource.getHinoDealers();
        final data = hinoResponse.data
            .where((e) =>
                e.facility == '1S' ||
                e.facility == '3S')
            .map(
              (e) => PlaceModel(
                name: e.name!,
                type: 'car_dealer',
                address: e.address,
                latitude: e.latitude.toString(),
                longitude: e.longitude.toString(),
                phone: 'N/A',
              ),
            )
            .toList();

        print('Hino Dealers aaaaaaa: $data');
        print('latitute type: $lat');
        print('longitude: $long');
        return data;
      } else if (type == 'service_center') {
        final hinoResponse = await hinoDataSource.getHinoDealers();
        final data = hinoResponse.data
            .where((e) =>
                e.facility == '2S' ||
                e.facility == '3S')
            .map(
              (e) => PlaceModel(
                name: e.name!,
                type: 'service_center',
                address: e.address,
                latitude: e.latitude.toString(),
                longitude: e.longitude.toString(),
                phone: 'N/A',
              ),
            )
            .toList();

        return data;
      } else {
        print('di esle jalan');
        final response = await dataSource.getPlaceList(lat, long, type);
        print('response diisiniii: $response');

        final data = response.results
            .where((e) =>
                e.name != null && e.longitude != null && e.latitude != null)
            .map(
              (e) => PlaceModel(
                name: e.name!,
                type: e.type!,
                address: e.address,
                latitude: e.latitude!.toString(),
                longitude: e.longitude!.toString(),
                phone: e.phone ?? 'N/A',
              ),
            )
            .toList();

        return data;
      }
    } catch (e) {
      //call error handler dialog
      print('error in place use case: $e');
      rethrow;
    }
  }
}
