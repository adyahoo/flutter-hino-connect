import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';

class MapsController extends GetxController {
  late GoogleMapController _controller;

  MapsController({required this.useCase});

  final PlaceUseCase useCase;
  final List<PlaceModel> data = <PlaceModel>[].obs;
  RxList<Marker> markers = <Marker>[].obs;

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  // void fetchPlaces(double lat, double long, String type) async {
  //   final res = await useCase.getPlaceList(lat, long, type);
  //   data.addAll(res);
  //   print('\n fetch places: ${data}');

  //   //clear old markers
  //   markers.clear();

  //   markers = data
  //       .map((e) => Marker(
  //             markerId: MarkerId(e.name),
  //             position:
  //                 LatLng(double.parse(e.latitude), double.parse(e.longitude)),
  //             infoWindow: InfoWindow(
  //               title: e.name,
  //               snippet: e.address,
  //             ),
  //             icon: BitmapDescriptor.defaultMarkerWithHue(
  //                 BitmapDescriptor.hueRed), // Change marker color here
  //           ))
  //       .toList()
  //       .obs;

  //   print('\n markers: ${markers}');
  // }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    final res = await useCase.getPlaceList(lat, long, type);
    data.addAll(res);
    print('\n fetch places: ${data}');

    //clear old markers
    markers.clear();

    markers = data
        .map((e) => Marker(
              markerId: MarkerId(e.name),
              position:
                  LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              infoWindow: InfoWindow(
                title: e.name,
                snippet: e.address,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed), // Change marker color here
            ))
        .toList()
        .obs;

    print('\n markers: ${markers}');
  }
}
