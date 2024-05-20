import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';
import 'package:hino_driver_app/infrastructure/map_utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geocoding/geocoding.dart';

final _panelController = PanelController();

class MapsController extends GetxController {
  late GoogleMapController _controller;

  //initial custom marker
  late BitmapDescriptor gas_station;
  late BitmapDescriptor restaurant;
  late BitmapDescriptor car_dealer;

  //selected custom marker
  late BitmapDescriptor selectedGasStation;
  late BitmapDescriptor selectedRestaurant;
  late BitmapDescriptor selectedCarDealer;

  final panelController = _panelController;

  MapsController({required this.useCase});

  final PlaceUseCase useCase;
  final List<PlaceModel> data = <PlaceModel>[].obs;
  List<PlaceModel> get places => data;

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});
  Set<Marker> get markers => _markers.value;

  Marker? selectedMarker; //store last selected marker
  RxString selectedChip = RxString('');

  final Rx<TextEditingController> searchbarController = TextEditingController().obs;
  final searchBarState = AppTextFieldState();

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
    // searchBarState.focusNode.value.addListener(searchBarState.onFocusChange);
    searchBarState.focusNode.value.addListener(searchBarState.onFocusChange);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchBarState.focusNode.value.removeListener(searchBarState.onFocusChange);
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void getCurrentLocation() {
  }
    

  void moveCamera(double lat, double long) {
    initMarker(_controller, lat, long);

    // Then animate the camera
    _controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
  }

  void initMarker(GoogleMapController controller, double lat, double long) {
    setController(controller);
    fetchAllPlaces(lat, long);
  }

  Future<void> fetchAllPlaces(double lat, double long) async {
    await fetchPlaces(lat, long, 'gas_station');
    await fetchPlaces(lat, long, 'restaurant');
    await fetchPlaces(lat, long, 'car_dealer');
  }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    final res = await useCase.getPlaceList(lat, long, type);
    data.addAll(res.where((place) => place.type == type));
    // print('\n fetch places: ${data}');

    _markers.value = data
        .map((e) => Marker(
              markerId: MarkerId(e.name),
              position:
                  LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              infoWindow: InfoWindow(
                title: e.name,
                snippet: e.address,
              ),
              icon: getIconForType(e.type),
              onTap: () {
                print('Marker tapped');
                onMarkerTapped(Marker(
                  markerId: MarkerId(e.name),
                  position: LatLng(
                      double.parse(e.latitude), double.parse(e.longitude)),
                ));
                print('\n type: ${e.type}');
              },
            ))
        .toSet();

    //add marker to the initial position
    _markers.value = Set<Marker>.from(_markers.value)
      ..add(Marker(
        markerId: MarkerId('Initial Position'),
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarker,
      ));
  }

  void filterMarkers(String label, bool isSelected, String chipId) {
    print('\n label: $label, isSelected: $isSelected, chipId: $chipId');

    String type = convertLabelToType(label);
    if (isSelected) {
      selectedChip.value = chipId;
      _markers.value = data
          .where((e) => e.type == type)
          .map((e) => Marker(
                markerId: MarkerId(e.name),
                position:
                    LatLng(double.parse(e.latitude), double.parse(e.longitude)),
                infoWindow: InfoWindow(
                  title: e.name,
                  snippet: e.address,
                ),
                icon: getIconForType(e.type),
                onTap: () {
                  print('Marker tapped');
                  onMarkerTapped(Marker(
                    markerId: MarkerId(e.name),
                    position: LatLng(
                        double.parse(e.latitude), double.parse(e.longitude)),
                  ));
                  print('\n type: ${e.type}');
                },
              ))
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
  print('\n placemarks: ${placemarks}');

  String formattedAddress = placemarks.first.street! +
      ', ' +
      placemarks.first.subLocality! +
      ', ' +
      placemarks.first.locality! +
      ', ' +
      placemarks.first.administrativeArea! +
      ', ' +
      placemarks.first.postalCode!;

  print('\n formattedAddress: ${formattedAddress}');

  return formattedAddress;
}

void onMarkerTapped(Marker marker) {
  // Update panel data
  placeName.value = marker.markerId.value;
  placeType.value = convertTypeName(
      data.firstWhere((e) => e.name == marker.markerId.value).type);
  phoneNumber.value =
      data.firstWhere((e) => e.name == marker.markerId.value).phone!;
  position.value =
      '${marker.position.latitude}, ${marker.position.longitude}';

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
    final gasStationBytes =
        await _getBytesFromAsset("ic_maps_gas_station.png", 120);
    final restaurantBytes =
        await _getBytesFromAsset("ic_maps_restaurant.png", 120);
    final hinoDealerBytes = await _getBytesFromAsset("ic_maps_dealer.png", 120);

    final selectedGasStationBytes =
        await _getBytesFromAsset("ic_maps_gas_station_selected.png", 120);
    final selectedRestaurantBytes =
        await _getBytesFromAsset("ic_maps_restaurant_selected.png", 120);
    final selectedHinoDealerBytes =
        await _getBytesFromAsset("ic_maps_dealer_selected.png", 120);

    gas_station = BitmapDescriptor.fromBytes(gasStationBytes);
    restaurant = BitmapDescriptor.fromBytes(restaurantBytes);
    car_dealer = BitmapDescriptor.fromBytes(hinoDealerBytes);

    selectedGasStation = BitmapDescriptor.fromBytes(selectedGasStationBytes);
    selectedRestaurant = BitmapDescriptor.fromBytes(selectedRestaurantBytes);
    selectedCarDealer = BitmapDescriptor.fromBytes(selectedHinoDealerBytes);
  }

  Future<Uint8List> _getBytesFromAsset(String assetName, int width) async {
    ByteData data = await rootBundle.load("assets/icons/${assetName}");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  BitmapDescriptor getIconForType(String type) {
    switch (type) {
      case 'gas_station':
        return gas_station;
      case 'restaurant':
        return restaurant;
      case 'car_dealer':
        return car_dealer;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void updateMarkerIcon(String markerId) {
    final marker = _markers.value
        .firstWhere((element) => element.markerId.value == markerId);
    final type = data.firstWhere((e) => e.name == markerId).type;

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

    _markers.value = Set<Marker>.from(
        _markers.value.where((m) => m.markerId != marker.markerId))
      ..add(updatedMarker);
  }

  void revertMarkerIcon(String markerId) {
    final marker = _markers.value
        .firstWhere((element) => element.markerId.value == markerId);
    final type = data.firstWhere((e) => e.name == markerId).type;

    BitmapDescriptor selectedIcon;
    switch (type) {
      case 'gas_station':
        selectedIcon = gas_station;
        break;
      case 'restaurant':
        selectedIcon = restaurant;
        break;
      case 'car_dealer':
        selectedIcon = car_dealer;
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

    _markers.value = Set<Marker>.from(
        _markers.value.where((m) => m.markerId != marker.markerId))
      ..add(updatedMarker);
  }
}
