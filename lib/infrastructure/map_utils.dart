import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';

class MapUtils {
  const MapUtils({
    required this.origin,
    required this.destination,
  });

  final LatLng origin;
  final LatLng destination;

  Future<List<LatLng>> getPolyLineRoute() async {
    final polylinePoints = PolylinePoints();
    final coordinates = <LatLng>[];

    final origin = PointLatLng(this.origin.latitude, this.origin.longitude);
    final dest = PointLatLng(this.destination.latitude, this.destination.longitude);

    final res = await polylinePoints.getRouteBetweenCoordinates(
      Constants.MAP_API_KEY,
      origin,
      dest,
    );

    if (res.points.isNotEmpty) {
      for (final point in res.points) {
        final latLng = LatLng(point.latitude, point.longitude);

        coordinates.add(latLng);
      }
    }

    return coordinates;
  }

  
}
