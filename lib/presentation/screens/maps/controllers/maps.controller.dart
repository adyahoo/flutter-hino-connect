import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/map_filter_model.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:geocoding/geocoding.dart';

final _panelController = PanelController();

class MapsController extends GetxController {
  MapsController({required this.useCase});

  final PlaceUseCase useCase;

  late GoogleMapController _controller;

  //initial custom marker
  late BitmapDescriptor gasStation;
  late BitmapDescriptor restaurant;
  late BitmapDescriptor carDealer;

  //selected custom marker
  late BitmapDescriptor selectedGasStation;
  late BitmapDescriptor selectedRestaurant;
  late BitmapDescriptor selectedCarDealer;

  final panelController = _panelController;

  final List<PlaceModel> _places = <PlaceModel>[].obs;

  List<PlaceModel> get places => _places;

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});

  Set<Marker> get markers => _markers.value;

  Marker? selectedMarker; //store last selected marker
  RxString selectedChip = RxString('');

  final Rx<TextEditingController> searchbarController = TextEditingController().obs;
  final searchBarState = AppTextFieldState();

  CameraPosition currentCameraPosition = CameraPosition(
    target: LatLng(-8.681547132266411, 115.24069589508952),
    zoom: 16,
  );
  LatLng currentLocation = LatLng(-8.681547132266411, 115.24069589508952);

  //place model default rx value
  var placeName = 'Name'.obs;
  var placeType = 'Type'.obs;
  var address = 'Address'.obs;
  var phoneNumber = 'Phone'.obs;
  var position = 'Position'.obs;

  @override
  void onInit() {
    _createCustomMarker();
    super.onInit();
    getCurrentLocation();
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

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation = LatLng(position.latitude, position.longitude);

      moveCamera(currentLocation);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void moveCamera(LatLng coordinate) {
    initMarker(coordinate);

    // Then animate the camera
    _controller.animateCamera(CameraUpdate.newLatLngZoom(coordinate, 15));
  }

  void initMarker(LatLng coordinate) {
    fetchAllPlaces(coordinate.latitude, coordinate.longitude);
  }

  Future<void> fetchAllPlaces(double lat, double long) async {
    await fetchPlaces(lat, long, 'gas_station');
    await fetchPlaces(lat, long, 'restaurant');
    await fetchPlaces(lat, long, 'car_dealer');
  }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    final res = await useCase.getPlaceList(lat, long, type);
    _places.addAll(res.where((place) => place.type == type));

    _markers.value = _places
        .map(
          (e) => _createMarker(e),
        )
        .toSet();

    //add marker to the initial position
    _markers.value = Set<Marker>.from(_markers.value)
      ..add(
        Marker(
          markerId: MarkerId('Initial Position'),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
  }

  void filterMarkers(String id) {
    if (id != '') {
      final item = Constants.mapScreenFilterItems.firstWhere((element) => element.id == id);
      String type = convertLabelToType(item.label);

      selectedChip.value = item.id;
      _markers.value = _places
          .where((e) => e.type == type)
          .map(
            (e) => Marker(
              markerId: MarkerId(e.name),
              position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              infoWindow: InfoWindow(
                title: e.name,
                snippet: e.address,
              ),
              icon: getIconForType(e.type),
              onTap: () {
                onMarkerTapped(
                  Marker(
                    markerId: MarkerId(e.name),
                    position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
                  ),
                );
              },
            ),
          )
          .toSet();
    } else {
      selectedChip.value = '';
      fetchAllPlaces(37.42796133580664, -122.085749655962);
    }
  }

  String convertLabelToType(String label) {
    switch (label) {
      case 'Gas Station':
        return 'gas_station';
      case 'Dealers':
        return 'car_dealer';
      case 'Restaurant':
        return 'restaurant';
      default:
        return '';
    }
  }

  String convertTypeName(String type) {
    switch (type) {
      case 'gas_station':
        return 'Gas Station';
      case 'restaurant':
        return 'Restaurant';
      case 'car_dealer':
        return 'Car Dealer';
      default:
        return 'Unknown';
    }
  }

  Future<String> fetchFormattedAddress(Marker marker) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(marker.position.latitude, marker.position.longitude);

    String formattedAddress =
        placemarks.first.street! + ', ' + placemarks.first.subLocality! + ', ' + placemarks.first.locality! + ', ' + placemarks.first.administrativeArea! + ', ' + placemarks.first.postalCode!;

    return formattedAddress;
  }

  Marker _createMarker(PlaceModel place) {
    return Marker(
      markerId: MarkerId(place.name),
      position: LatLng(
        double.parse(place.latitude),
        double.parse(place.longitude),
      ),
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.address,
      ),
      icon: getIconForType(place.type),
      onTap: () {
        onMarkerTapped(
          Marker(
            markerId: MarkerId(place.name),
            position: LatLng(
              double.parse(place.latitude),
              double.parse(place.longitude),
            ),
          ),
        );
      },
    );
  }

  void onMarkerTapped(Marker marker) {
    // Update panel data
    placeName.value = marker.markerId.value;
    placeType.value = convertTypeName(_places.firstWhere((e) => e.name == marker.markerId.value).type);
    phoneNumber.value = _places.firstWhere((e) => e.name == marker.markerId.value).phone!;
    position.value = '${marker.position.latitude}, ${marker.position.longitude}';

    // Fetch and update address in the background
    fetchFormattedAddress(marker).then((formattedAddress) {
      address.value = formattedAddress;
    });

    // Update marker icon
    updateMarkerIcon(marker.markerId.value);

    // Check if marker is already selected
    if (selectedMarker != null && selectedMarker!.markerId == marker.markerId) {
      // Toggle panel
      if (panelController.isPanelOpen) {
        panelController.close();
        // Close info window
        _controller.hideMarkerInfoWindow(marker.markerId);
        // Revert marker icon
        revertMarkerIcon(marker.markerId.value);
      } else {
        panelController.open();
      }
    } else {
      // Revert last selected marker icon
      if (selectedMarker != null) {
        revertMarkerIcon(selectedMarker!.markerId.value);
      }
      // Store selected marker
      selectedMarker = marker;
      // Open panel
      panelController.open();
    }
  }

  Future<void> _createCustomMarker() async {
    final gasStationBytes = await _getBytesFromAsset("ic_maps_gas_station.png", 120);
    final restaurantBytes = await _getBytesFromAsset("ic_maps_restaurant.png", 120);
    final hinoDealerBytes = await _getBytesFromAsset("ic_maps_dealer.png", 120);

    final selectedGasStationBytes = await _getBytesFromAsset("ic_maps_gas_station_selected.png", 120);
    final selectedRestaurantBytes = await _getBytesFromAsset("ic_maps_restaurant_selected.png", 120);
    final selectedHinoDealerBytes = await _getBytesFromAsset("ic_maps_dealer_selected.png", 120);

    gasStation = BitmapDescriptor.fromBytes(gasStationBytes);
    restaurant = BitmapDescriptor.fromBytes(restaurantBytes);
    carDealer = BitmapDescriptor.fromBytes(hinoDealerBytes);

    selectedGasStation = BitmapDescriptor.fromBytes(selectedGasStationBytes);
    selectedRestaurant = BitmapDescriptor.fromBytes(selectedRestaurantBytes);
    selectedCarDealer = BitmapDescriptor.fromBytes(selectedHinoDealerBytes);
  }

  Future<Uint8List> _getBytesFromAsset(String assetName, int width) async {
    ByteData data = await rootBundle.load("assets/icons/${assetName}");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  BitmapDescriptor getIconForType(String type) {
    switch (type) {
      case 'gas_station':
        return gasStation;
      case 'restaurant':
        return restaurant;
      case 'car_dealer':
        return carDealer;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void updateMarkerIcon(String markerId) {
    final marker = _markers.value.firstWhere((element) => element.markerId.value == markerId);
    final type = _places.firstWhere((e) => e.name == markerId).type;

    BitmapDescriptor selectedIcon;
    switch (type) {
      case 'gas_station':
        selectedIcon = selectedGasStation;
        break;
      case 'restaurant':
        selectedIcon = selectedRestaurant;
        break;
      case 'car_dealer':
        selectedIcon = selectedCarDealer;
        break;
      default:
        selectedIcon = BitmapDescriptor.defaultMarker;
    }

    final updatedMarker = Marker(
      markerId: marker.markerId,
      position: marker.position,
      infoWindow: marker.infoWindow,
      icon: selectedIcon,
      onTap: marker.onTap,
    );

    _markers.value = Set<Marker>.from(_markers.value.where((m) => m.markerId != marker.markerId))..add(updatedMarker);
  }

  void revertMarkerIcon(String markerId) {
    final marker = _markers.value.firstWhere((element) => element.markerId.value == markerId);
    final type = _places.firstWhere((e) => e.name == markerId).type;

    BitmapDescriptor selectedIcon;
    switch (type) {
      case 'gas_station':
        selectedIcon = gasStation;
        break;
      case 'restaurant':
        selectedIcon = restaurant;
        break;
      case 'car_dealer':
        selectedIcon = carDealer;
        break;
      default:
        selectedIcon = BitmapDescriptor.defaultMarker;
    }

    final updatedMarker = Marker(
      markerId: marker.markerId,
      position: marker.position,
      infoWindow: marker.infoWindow,
      icon: selectedIcon,
      onTap: marker.onTap,
    );

    _markers.value = Set<Marker>.from(_markers.value.where((m) => m.markerId != marker.markerId))..add(updatedMarker);
  }

  void onMapTap(LatLng coordinate) {
    if (selectedMarker != null) {
      revertMarkerIcon(selectedMarker!.markerId.value);
    }
    panelController.close();
  }

  void navigateSearch(String? query) async {
    final callback = await Get.toNamed(
      Routes.SEARCH,
      arguments: {'query': query},
    );

    filterMarkers(callback);
  }
}
