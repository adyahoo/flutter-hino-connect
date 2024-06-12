import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  static final zoom = 20.0;
  late GoogleMapController _controller;

  //initial custom marker
  late BitmapDescriptor gasStation;
  late BitmapDescriptor restaurant;
  late BitmapDescriptor carDealer;
  late BitmapDescriptor serviceCenter;

  //selected custom marker
  late BitmapDescriptor selectedGasStation;
  late BitmapDescriptor selectedRestaurant;
  late BitmapDescriptor selectedCarDealer;
  late BitmapDescriptor selectedServiceCenter;

  final panelController = _panelController;

  List<PlaceModel> _places = <PlaceModel>[].obs;

  List<PlaceModel> get places => _places;

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});
  Rx<Set<Marker>> currentMarker = Rx<Set<Marker>>({});

  Set<Marker> get markers => _markers.value;

  Marker? selectedMarker; //store last selected marker
  RxString selectedChip = RxString('');

  final Rx<TextEditingController> searchbarController =
      TextEditingController().obs;
  final searchBarState = AppTextFieldState();

  LatLng currentLocation = LatLng(-8.681547132266411, 115.24069589508952);
  CameraPosition currentCameraPosition = CameraPosition(
    target: LatLng(-6.3003589142707925, 106.63645869332062),
    zoom: zoom,
  );

  //TEMPORARY VENUE LOCATION
  final LatLng venueLocation = LatLng(-6.3003589142707925, 106.63645869332062);

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
  }

  @override
  void onReady() {
    super.onReady();
    // getCurrentLocation();
    loadVenueAsCurrentLocation();
    // _addCurrentLocationMarker();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> loadVenueAsCurrentLocation() async {
    currentLocation = venueLocation;
    initMarker(currentLocation);
    _addCurrentLocationMarker();
    moveCamera(currentLocation);
  }

  // Future<void> getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low,
  //     );

  //     if (currentLocation.latitude.isEqual(position.latitude)) {
  //       currentLocation = LatLng(position.latitude, position.longitude);
  //       _addCurrentLocationMarker();
  //     }

  //     moveCamera(currentLocation);
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  void moveCamera(LatLng coordinate) {
    _controller.animateCamera(CameraUpdate.newLatLngZoom(coordinate, zoom));
    // Then init marker
    initMarker(coordinate);
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
    moveCamera(
        LatLng(double.parse(place.latitude), double.parse(place.longitude)));
    await fetchAllPlaces(
        double.parse(place.latitude), double.parse(place.longitude));

    // Check if the fetched places contain the specific marker we want to initialize
    String markerId = generateMarkerId(
        double.parse(place.latitude), double.parse(place.longitude));

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
        position:
            LatLng(double.parse(place.latitude), double.parse(place.longitude)),
        icon: getIconForType(place.type),
        onTap: () {
          print('Marker tapped blabla');
          onMarkerTapped(Marker(
            markerId: MarkerId(markerId),
            position: LatLng(
                double.parse(place.latitude), double.parse(place.longitude)),
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

  Future<void> fetchAllPlaces(double lat, double long,
      {bool isFetchingCurrentLocation = false}) async {
    try {
      print('--fetch all places--');
      await fetchPlaces(lat, long, 'gas_station');
      await fetchPlaces(lat, long, 'restaurant');
      await fetchPlaces(lat, long, 'car_dealer');
      await fetchPlaces(lat, long, 'service_center');
    } catch (e) {
      print('error in fetch all places: $e');
    }
  }

  void _addCurrentLocationMarker() {
    currentMarker.value = {
      Marker(
        markerId: MarkerId('Initial Position'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarker,
      ),
    };
  }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    try {
      print('fetching places');
      final res = await useCase.getPlaceList(lat, long, type);
      print('res: $res');

      // Filter places with the correct type and valid latitude/longitude
      final validPlaces = res.where((place) {
        if (place.type != type) return false;
        if (place.latitude == null || place.longitude == null) return false;
        if (place.latitude!.isEmpty || place.longitude!.isEmpty) return false;
        if (double.tryParse(place.latitude!) == null ||
            double.tryParse(place.longitude!) == null) return false;
        return true;
      }).toList();

      _places = [..._places, ...validPlaces];
      // Create a temporary set of new markers
      final newMarkers = _places
          .map((e) => _createMarker(e))
          // ignore: unnecessary_null_comparison
          .where((marker) =>
              marker != null) // Ensure only non-null markers are added
          .cast<Marker>()
          .toSet();

      // Add new markers to the existing set
      _markers.value = Set<Marker>.from(_markers.value)..addAll(newMarkers);

      // Update the _markers observable with the new set of markers
      _markers.refresh(); // or _markers.value = _markers.toSet();
    } catch (e) {
      print('error in fetch places: $e');
    }
  }

  // void filterMarkers(String id) {
  //   print('-----------------');
  //   print('ID: $id');
  //   print('-----------------');
  //   if (id != '') {
  //     print('masuk di if id != "');
  //     if (id == 'filter_drive_to') {
  //       //open google maps app
  //     }

  //     final item = Constants.mapScreenFilterItems
  //         .firstWhere((element) => element.id == id);
  //     String type = convertLabelToType(item.label);
  //     print('TYPE: $type');
  //     print('ITEM: $item');

  //     selectedChip.value = item.id;
  //     _markers.value = _places
  //         .where((e) => e.type == type)
  //         .map(
  //           (e) => Marker(
  //             markerId: MarkerId(generateMarkerId(
  //                 double.parse(e.latitude), double.parse(e.longitude))),
  //             position:
  //                 LatLng(double.parse(e.latitude), double.parse(e.longitude)),
  //             infoWindow: InfoWindow(
  //               title: e.name,
  //               snippet: e.address,
  //             ),
  //             icon: getIconForType(e.type),
  //             onTap: () {
  //               onMarkerTapped(
  //                 Marker(
  //                   markerId: MarkerId(generateMarkerId(
  //                       double.parse(e.latitude), double.parse(e.longitude))),
  //                   position: LatLng(
  //                       double.parse(e.latitude), double.parse(e.longitude)),
  //                 ),
  //               );
  //             },
  //           ),
  //         )
  //         .toSet();
  //   } else {
  //     print('masuk di else filter markers');
  //     selectedChip.value = '';
  //     _markers.value = _places
  //         .map(
  //           (e) => Marker(
  //             markerId: MarkerId(generateMarkerId(
  //                 double.parse(e.latitude), double.parse(e.longitude))),
  //             position:
  //                 LatLng(double.parse(e.latitude), double.parse(e.longitude)),
  //             infoWindow: InfoWindow(
  //               title: e.name,
  //               snippet: e.address,
  //             ),
  //             icon: getIconForType(e.type),
  //             onTap: () {
  //               onMarkerTapped(
  //                 Marker(
  //                   markerId: MarkerId(generateMarkerId(
  //                       double.parse(e.latitude), double.parse(e.longitude))),
  //                   position: LatLng(
  //                       double.parse(e.latitude), double.parse(e.longitude)),
  //                 ),
  //               );
  //             },
  //           ),
  //         )
  //         .toSet();
  //     // fetchAllPlaces(currentLocation.latitude, currentLocation.longitude);
  //   }
  // }

void filterMarkers(String id) {
  print('-----------------');
  print('ID: $id');
  print('-----------------');

  if (id.isNotEmpty) {
    print('Filter ID provided.');

    if (id == 'filter_drive_to') {
      // open Google Maps app
    }

    final item = Constants.mapScreenFilterItems
        .firstWhere((element) => element.id == id);
    final type = convertLabelToType(item.label);

    print('TYPE: $type');
    print('ITEM: $item');

    selectedChip.value = item.id;
    _markers.value = _createMarkers(_places.where((e) => e.type == type));
  } else {
    print('No filter ID provided. Displaying all markers.');

    selectedChip.value = '';
    _markers.value = _createMarkers(_places);
  }
}

Set<Marker> _createMarkers(Iterable<PlaceModel> places) {
  return places
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
}

  Marker _createMarker(PlaceModel place) {
    print('jalaaan');
    String markerId = generateMarkerId(
        double.parse(place.latitude), double.parse(place.longitude));

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
        print('Marker tapped blabla');
        print('MARKER ID: $markerId');
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

//   void onMarkerTapped(Marker marker) {
//   print('jalan di marker tapped');
//   print('MARKER ID di dalam: ${marker.markerId.value}');

//   final selectedPlace = _places.firstWhere((e) =>
//       generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) ==
//       marker.markerId.value);

//   print('SELECTED PLACE: $selectedPlace');
//   print('type selected place: ${selectedPlace.type}');
//   print('MARKER INFO: ${marker.markerId.value}');

//   // Check if there's a marker with a different type at the same position
//   final samePositionMarker = _places.firstWhere(
//     (e) =>
//         double.parse(e.latitude) == marker.position.latitude &&
//         double.parse(e.longitude) == marker.position.longitude &&
//         e.type != selectedPlace.type,
   
//   );

//   if (samePositionMarker != null) {
//     // If there's a marker with a different type, change the type to 'car dealer and service center'
//     selectedPlace.type = 'car dealer and service center';
//   }

//   placeName.value = selectedPlace.name;
//   // placeType.value = convertTypeName(selectedPlace.type);
//   placeType.value = selectedPlace.type;
//   phoneNumber.value = selectedPlace.phone!;
//   position.value =
//       '${marker.position.latitude}, ${marker.position.longitude}';
//   address.value = selectedPlace.address ?? '';

//   // Update marker icon
//   updateMarkerIcon(marker.markerId.value);

//   // Check if marker is already selected
//   if (selectedMarker != null && selectedMarker!.markerId == marker.markerId) {
//     // Toggle panel
//     if (panelController.isPanelOpen) {
//       panelController.close();
//       // Close info window
//       _controller.hideMarkerInfoWindow(marker.markerId);
//       // Revert marker icon
//       revertMarkerIcon(marker.markerId.value);
//     } else {
//       panelController.open();
//     }
//   } else {
//     // Revert last selected marker icon
//     if (selectedMarker != null) {
//       revertMarkerIcon(selectedMarker!.markerId.value);
//     }
//     // Store selected marker
//     selectedMarker = marker;
//     // Open panel
//     panelController.open();
//   }
// }

  void onMarkerTapped(Marker marker) {
    print('jalan di marker tapped');
    print('MARKER ID di dalam: ${marker.markerId.value}');
    // Update panel data
    // final selectedPlace = _places.firstWhere((e) =>
    //     generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) ==
    //     marker.markerId.value);

    // try {
    //   print('try');
    //   final selectedPlace = _places.firstWhere((e) =>
    //       generateMarkerId(
    //           double.parse(e.latitude), double.parse(e.longitude)) ==
    //       marker.markerId.value);
    // } catch (e) {
    //   print('error: $e');
    // }

    final selectedPlace = _places.firstWhere((e) =>
        generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) ==
        marker.markerId.value);

    print('SELECTED PLACE: $selectedPlace');
    print('type selected place: ${selectedPlace.type}');

    print('MARKER INFO: ${marker.markerId.value}');

    placeName.value = selectedPlace.name;
    placeType.value = convertTypeName(selectedPlace.type);
    phoneNumber.value = selectedPlace.phone!;
    position.value =
        '${marker.position.latitude}, ${marker.position.longitude}';
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
    final gasStationBytes =
        await _getBytesFromAsset("ic_maps_gas_station.png", 120);
    final restaurantBytes =
        await _getBytesFromAsset("ic_maps_restaurant.png", 120);
    final hinoDealerBytes = await _getBytesFromAsset("ic_maps_dealer.png", 120);
    final serviceCenterBytes =
        await _getBytesFromAsset("ic_maps_service_center.png", 120);

    final selectedGasStationBytes =
        await _getBytesFromAsset("ic_maps_gas_station_selected.png", 120);
    final selectedRestaurantBytes =
        await _getBytesFromAsset("ic_maps_restaurant_selected.png", 120);
    final selectedHinoDealerBytes =
        await _getBytesFromAsset("ic_maps_dealer_selected.png", 120);
    final selectedServiceCenterBytes =
        await _getBytesFromAsset("ic_maps_service_center_selected.png", 120);

    gasStation = BitmapDescriptor.fromBytes(gasStationBytes);
    restaurant = BitmapDescriptor.fromBytes(restaurantBytes);
    carDealer = BitmapDescriptor.fromBytes(hinoDealerBytes);
    serviceCenter = BitmapDescriptor.fromBytes(serviceCenterBytes);

    selectedGasStation = BitmapDescriptor.fromBytes(selectedGasStationBytes);
    selectedRestaurant = BitmapDescriptor.fromBytes(selectedRestaurantBytes);
    selectedCarDealer = BitmapDescriptor.fromBytes(selectedHinoDealerBytes);
    selectedServiceCenter = BitmapDescriptor.fromBytes(selectedServiceCenterBytes);
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
        return gasStation;
      case 'restaurant':
        return restaurant;
      case 'car_dealer':
        return carDealer;
      case 'service_center':
        return serviceCenter;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void updateMarkerIcon(String markerId) {
    final marker = _markers.value
        .firstWhere((element) => element.markerId.value == markerId);
    final type = _places
        .firstWhere((e) =>
            generateMarkerId(
                double.parse(e.latitude), double.parse(e.longitude)) ==
            markerId)
        .type;

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
      case 'service_center':
        selectedIcon = selectedServiceCenter;
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
    final type = _places
        .firstWhere((e) =>
            generateMarkerId(
                double.parse(e.latitude), double.parse(e.longitude)) ==
            markerId)
        .type;

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
      case 'service_center':
        icon = serviceCenter;
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

    _markers.value = Set<Marker>.from(
        _markers.value.where((m) => m.markerId != marker.markerId))
      ..add(updatedMarker);
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
      case 'Service Center':
        return 'service_center';
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
      case 'service_center':
        return 'Service Center';
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