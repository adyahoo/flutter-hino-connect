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

  List<PlaceModel> _places = <PlaceModel>[].obs;

  List<PlaceModel> get places => _places;

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});

  Set<Marker> get markers => _markers.value;

  Marker? selectedMarker; //store last selected marker
  RxString selectedChip = RxString('');

  final Rx<TextEditingController> searchbarController = TextEditingController().obs;
  final searchBarState = AppTextFieldState();

  CameraPosition currentCameraPosition = CameraPosition(
    target: LatLng(-8.681547132266411, 115.24069589508952),
    zoom: 20,
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
    // getCurrentLocation();
  }

  @override
  void onReady() {
    super.onReady();
    getCurrentLocation();
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
    _controller.animateCamera(CameraUpdate.newLatLngZoom(coordinate, 20));
  }

  void initMarker(LatLng coordinate) {
    fetchAllPlaces(
      coordinate.latitude,
      coordinate.longitude,
      isFetchingCurrentLocation: true,
    );
  }

  Future<void> initSpecificMarker(PlaceModel place) async {
    // Wait for fetchAllPlaces to complete
    await fetchAllPlaces(double.parse(place.latitude), double.parse(place.longitude));

    // Check if the fetched places contain the specific marker we want to initialize
    String markerId = generateMarkerId(double.parse(place.latitude), double.parse(place.longitude));

    // Search for marker in _markers
    Marker? marker;
    for (var element in _markers.value) {
      if (element.markerId.value == markerId) {
        marker = element;
        break;
      }
    }

    if (marker != null) {
      print('Marker found');
      onMarkerTapped(marker);
    } else {
      print('Marker not found');

      // Add new marker
      Marker newMarker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(double.parse(place.latitude), double.parse(place.longitude)),
        icon: getIconForType(place.type),
        onTap: () {
          print('Marker tapped blabla');
          onMarkerTapped(Marker(
            markerId: MarkerId(markerId),
            position: LatLng(double.parse(place.latitude), double.parse(place.longitude)),
          ));
        },
      );
      _markers.value = Set<Marker>.from(_markers.value)..add(newMarker);
      // Call onMarkerTapped with the new marker
      PlaceModel newPlace = PlaceModel(
        name: place.name,
        type: place.type,
        address: place.address,
        latitude: place.latitude,
        longitude: place.longitude,
        phone: place.phone,
      );

      final newPlaceList = [newPlace, ..._places];
      _places = newPlaceList;
      onMarkerTapped(newMarker);
    }
  }

  Future<void> fetchAllPlaces(double lat, double long, {bool isFetchingCurrentLocation = false}) async {
    await fetchPlaces(lat, long, 'gas_station');
    await fetchPlaces(lat, long, 'restaurant');
    await fetchPlaces(lat, long, 'car_dealer');

    if (isFetchingCurrentLocation) {
      // Add the initial marker after all places have been fetched
      _markers.value = Set<Marker>.from(_markers.value)
        ..add(
          Marker(
            markerId: MarkerId('Initial Position'),
            position: LatLng(lat, long),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      return;
    } else {
      _controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 20));
    }
  }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    final res = await useCase.getPlaceList(lat, long, type);
    _places.addAll(res.where((place) => place.type == type));

    _markers.value = _places
        .map(
          (e) => _createMarker(e),
        )
        .toSet();
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
              markerId: MarkerId(generateMarkerId(double.parse(e.latitude), double.parse(e.longitude))),
              position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              infoWindow: InfoWindow(
                title: e.name,
                snippet: e.address,
              ),
              icon: getIconForType(e.type),
              onTap: () {
                onMarkerTapped(
                  Marker(
                    markerId: MarkerId(generateMarkerId(double.parse(e.latitude), double.parse(e.longitude))),
                    position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
                  ),
                );
              },
            ),
          )
          .toSet();
    } else {
      selectedChip.value = '';
      fetchAllPlaces(currentLocation.latitude, currentLocation.longitude);
    }
  }

  Marker _createMarker(PlaceModel place) {
    String markerId = generateMarkerId(double.parse(place.latitude), double.parse(place.longitude));
    return Marker(
      markerId: MarkerId(markerId),
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
        print('KETAP HIKS');
        onMarkerTapped(
          Marker(
            markerId: MarkerId(markerId),
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
    final selectedPlace = _places.firstWhere((e) => generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == marker.markerId.value);

    print('MARKER INFO: ${marker.markerId.value}');

    placeName.value = selectedPlace.name;
    placeType.value = convertTypeName(selectedPlace.type);
    phoneNumber.value = selectedPlace.phone!;
    position.value = '${marker.position.latitude}, ${marker.position.longitude}';
    address.value = selectedPlace.address ?? '';

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
    final type = _places.firstWhere((e) => generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == markerId).type;

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
    final type = _places.firstWhere((e) => generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == markerId).type;

    BitmapDescriptor icon;
    switch (type) {
      case 'gas_station':
        icon = gasStation;
        break;
      case 'restaurant':
        icon = restaurant;
        break;
      case 'car_dealer':
        icon = carDealer;
        break;
      default:
        icon = BitmapDescriptor.defaultMarker;
    }

    final updatedMarker = Marker(
      markerId: marker.markerId,
      position: marker.position,
      infoWindow: marker.infoWindow,
      icon: icon,
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

  String generateMarkerId(double latitude, double longitude) {
    return '$latitude,$longitude';
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

  void navigateSearch(String? query) async {
    final callback = await Get.toNamed(
      Routes.SEARCH,
      arguments: {'query': query},
    );

    filterMarkers(callback);
  }
}
