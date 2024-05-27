import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:http/http.dart' as http;

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
    final dest =
        PointLatLng(this.destination.latitude, this.destination.longitude);

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

  Future<List<Placemark>> getAddressFromCoordinate(
      {LatLng? coordinate = null}) async {
    LatLng latLng = origin;

    if (coordinate != null) {
      latLng = coordinate;
    }

    return await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  }

  Future<PlaceModel> getPlaceDetails(double lat, double lng) async {
    String apiKey = Constants.MAP_API_KEY;

    // Reverse Geocoding URL
    String reverseGeocodingUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    // Send a GET request to the Reverse Geocoding API
    var response = await http.get(Uri.parse(reverseGeocodingUrl));

    // If the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(response.body);

      // Get the Place ID from the first result
      String placeId = jsonResponse['results'][0]['place_id'];

      // Place Details URL
      String placeDetailsUrl =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

      // Send a GET request to the Place Details API
      var detailsResponse = await http.get(Uri.parse(placeDetailsUrl));

      // If the request was successful
      if (detailsResponse.statusCode == 200) {
        // Parse the JSON response
        var detailsJson = jsonDecode(detailsResponse.body);

        // Create a new Place object from the JSON response
        PlaceModel place = PlaceModel(
          name: detailsJson['result']['name'],
          address: detailsJson['result']['formatted_address'],
          phone: detailsJson['result']['formatted_phone_number'],
          latitude:
              detailsJson['result']['geometry']['location']['lat'].toString(),
          longitude:
              detailsJson['result']['geometry']['location']['lng'].toString(),
          type: detailsJson['result']['types'][0],
        );

        return place;
      } else {
        throw Exception('Failed to load place details');
      }
    } else {
      throw Exception('Failed to load place ID');
    }
  }
}
