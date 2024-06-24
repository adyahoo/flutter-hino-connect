import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:http/http.dart';

class MapUtils {
  const MapUtils({
    required this.origin,
    required this.destination,
  });

  final LatLng origin;
  final LatLng destination;

 Future<List<LatLng>> getPolyLineRoute(List<String> penalties) async {
  final polylinePoints = PolylinePoints();
  final coordinates = <LatLng>[];

  try {
    final origin = PointLatLng(this.origin.latitude, this.origin.longitude);
    final dest = PointLatLng(this.destination.latitude, this.destination.longitude);

    final waypoints = penalties.map((e) => PolylineWayPoint(location: e)).toList();
    final res = await polylinePoints.getRouteBetweenCoordinates(
      Constants.MAP_API_KEY,
      origin,
      dest,
      wayPoints: waypoints,
    );

    if (res.points.isNotEmpty) {
      for (final point in res.points) {
        final latLng = LatLng(point.latitude, point.longitude);
        coordinates.add(latLng);
      }
    }
  } catch (e) {
    print('Error getting polyline route: $e');
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

  return coordinates;
}

  Future<List<Placemark>> getAddressFromCoordinate({LatLng? coordinate = null}) async {
    LatLng latLng = origin;

    if (coordinate != null) {
      latLng = coordinate;
    }

    return await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  }
}
