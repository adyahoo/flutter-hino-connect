import 'package:dio/dio.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:http/http.dart';

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
      print('--> getPlaceList: $type');
      final hinoResponse = await hinoDataSource.getHinoDealers();
      print('after hinoResponse: ${hinoResponse.data.length}');
      print('------------------------------------->');
      print('hinoResponse: ${hinoResponse.data[0].toString()}');
      if (type == Constants.TYPE_CAR_DEALER) {
        print('masuk if type car dealer');
        //print all data
        for (var item in hinoResponse.data) {
          print('data: ${item.name}');
        }
        print('facility 1s: ${Constants.FACILITY_1S}');
        final data = hinoResponse.data
            .where((e) => e.facility == Constants.FACILITY_1S)
            .map(
              (e) => PlaceModel(
                name: e.name!,
                type: Constants.TYPE_CAR_DEALER,
                address: e.address,
                latitude: e.latitude.toString(),
                longitude: e.longitude.toString(),
                phone: 'N/A',
              ),
            )
            .toList();

        print('data ajajajajja: $data');
        return data;
      } else if (type == Constants.TYPE_SERVICE_CENTER) {
        print('masuk if type service center');
        final data = hinoResponse.data
            .where((e) => e.facility == Constants.FACILITY_2S || e.facility == Constants.FACILITY_SERPO || e.facility == Constants.FACILITY_HMSI_2S || e.facility == Constants.FACILITY_3S)
            .map(
              (e) => PlaceModel(
                name: e.name!,
                type: Constants.TYPE_SERVICE_CENTER,
                address: e.address,
                latitude: e.latitude.toString(),
                longitude: e.longitude.toString(),
                phone: 'N/A',
              ),
            )
            .toList();

        print('data ajajajajja service: $data');
        return data;
      } else {
        final response = await dataSource.getPlaceList(lat, long, type);
        final data = response.results
            .where((e) => e.name != null && e.longitude != null && e.latitude != null)
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
      print('error in place use case: $e');
      if (e is ClientException && e.message.contains('Failed host lookup')) {
        print('Network connectivity issue detected: ${e.message}');

        //pass to error handler as Api Exception
        final apiException = ApiException(
          response: null,
          exception: DioException(
            type: DioExceptionType.connectionError,
            error: e.message,
            requestOptions: RequestOptions(),
          ),
        );

        errorHandler(apiException);
      }
      rethrow;
    }
  }
}
