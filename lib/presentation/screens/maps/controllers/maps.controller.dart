import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/domain/core/usecases/place_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

final _panelController = PanelController();

class MapsController extends GetxController {
  MapsController({required this.useCase});

  final PlaceUseCase useCase;

  static const double _zoom = 20.0;
  late GoogleMapController _controller;

  // Custom markers
  late BitmapDescriptor gasStation;
  late BitmapDescriptor restaurant;
  late BitmapDescriptor carDealer;
  late BitmapDescriptor serviceCenter;

  // Selected custom markers
  late BitmapDescriptor selectedGasStation;
  late BitmapDescriptor selectedRestaurant;
  late BitmapDescriptor selectedCarDealer;
  late BitmapDescriptor selectedServiceCenter;

  final panelController = _panelController;

  final List<PlaceModel> _places = <PlaceModel>[].obs;
  final Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});
  final Rx<Set<Marker>> currentMarker = Rx<Set<Marker>>({});

  List<PlaceModel> get places => _places;

  Set<Marker> get markers => _markers.value;

  Marker? selectedMarker;
  final RxString selectedChip = RxString('');

  final Rx<TextEditingController> searchbarController = TextEditingController().obs;
  final searchBarState = AppTextFieldState();

  LatLng currentLocation = const LatLng(-8.681547132266411, 115.24069589508952);
  CameraPosition currentCameraPosition = const CameraPosition(
    target: LatLng(-6.3003589142707925, 106.63645869332062),
    zoom: _zoom,
  );

  //rx place details
  var placeDetails = PlaceDetails(
    name: 'Name',
    type: 'Type',
    address: 'Address',
    phoneNumber: 'Phone',
    position: 'Position',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    _createCustomMarker();
  }

  @override
  void onReady() {
    super.onReady();
    loadVenueAsCurrentLocation();
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
    currentLocation = Constants.venueLocation;
    initMarker(currentLocation);
    _addCurrentLocationMarker();
    _moveCamera(currentLocation);
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      currentLocation = LatLng(position.latitude, position.longitude);

      _moveCamera(currentLocation);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void onMapTap(LatLng coordinate) {
    if (selectedMarker != null) {
      _revertMarkerIcon(selectedMarker!.markerId.value);
    }
    panelController.close();
  }

  void _moveCamera(LatLng coordinate) {
    _controller.animateCamera(CameraUpdate.newLatLngZoom(coordinate, _zoom));
    initMarker(coordinate);
  }

  void _addCurrentLocationMarker() {
    currentMarker.value = {
      Marker(
        markerId: MarkerId('current_location'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarker,
      )
    };
  }

  void initMarker(LatLng coordinate) {
    fetchAllPlaces(coordinate.latitude, coordinate.longitude, isFetchingCurrentLocation: true);
  }

  Future<void> initSpecificMarker(PlaceModel place) async {
    // Wait for fetchAllPlaces to complete
    _moveCamera(LatLng(double.parse(place.latitude), double.parse(place.longitude)));
    await fetchAllPlaces(double.parse(place.latitude), double.parse(place.longitude));

    // Check if the fetched places contain the specific marker we want to initialize
    String markerId = _generateMarkerId(double.parse(place.latitude), double.parse(place.longitude));

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
      print('abis ngetap marker di initSpecificMarker, marker if');
    } else {
      print('Marker not found');

      // Add new marker
      Marker newMarker = _createMarker(place) as Marker;
      _markers.value = Set<Marker>.from(_markers.value)..add(newMarker);

      final newPlaceList = [place, ..._places];
      _places.addAll(newPlaceList);

      onMarkerTapped(newMarker);
      print('abis ngetap marker di initSpecificMarker, marker else');
    }
  }

  Future<void> fetchAllPlaces(double lat, double long, {bool isFetchingCurrentLocation = false}) async {
    try {
      await Future.wait([
        fetchPlaces(lat, long, Constants.TYPE_GAS_STATION),
        fetchPlaces(lat, long, Constants.TYPE_RESTAURANT),
        fetchPlaces(lat, long, Constants.TYPE_CAR_DEALER),
        fetchPlaces(lat, long, Constants.TYPE_SERVICE_CENTER),
      ]);
    } catch (e) {
      print('Error fetching all places: $e');
    }
  }

  bool isValidPlace(PlaceModel place, String type) {
    return place.type == type &&
        place.latitude != null &&
        place.longitude != null &&
        place.latitude!.isNotEmpty &&
        place.longitude!.isNotEmpty &&
        double.tryParse(place.latitude!) != null &&
        double.tryParse(place.longitude!) != null;
  }

  Future<void> fetchPlaces(double lat, double long, String type) async {
    try {
      print('Fetching places for type: $type');
      final res = await useCase.getPlaceList(lat, long, type);

      if (type == Constants.TYPE_CAR_DEALER) {
        print('-' * 50);
        print('Test res car dealer: ${res.length}');
      } else if (type == Constants.TYPE_SERVICE_CENTER) {
        print('Test res service center: ${res.length}');
      }

      final validPlaces = res.where((place) => isValidPlace(place, type)).toList();

      if (type == Constants.TYPE_CAR_DEALER) {
        print('-' * 50);
        print('Car dealer: ${validPlaces.length}');
        for (var place in validPlaces) {
          print('Car dealer: ${place.name}');
        }
      } else if (type == Constants.TYPE_SERVICE_CENTER) {
        print('Service center: ${validPlaces.length}');
      }

      _places.addAll(validPlaces);
      final newMarkers = _places.map((e) => _createMarker(e)).whereType<Marker>().toSet();
      _markers.value.addAll(newMarkers);
      _markers.refresh();
    } catch (e) {
      print('Error fetching places: $e');
    }
  }

  void handleControlPanel(Marker? marker) {
    if (panelController.isPanelOpen) {
      _controller.hideMarkerInfoWindow(selectedMarker!.markerId);
      selectedMarker = null;
      panelController.close();
    } else if (marker != null) {
      selectedMarker = marker;
      panelController.open();
    }
  }

  Future<void> handleOpenMaps() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    currentLocation = LatLng(position.latitude, position.longitude);

    String url = '';
    String urlAppleMaps = '';

    // Define origin and destination strings
    String origin = '${currentLocation.latitude},${currentLocation.longitude}';
    String destination = '${selectedMarker!.position.latitude},${selectedMarker!.position.longitude}';

    if (Platform.isAndroid) {
      // Updated URL for Google Maps with directions
      url = 'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      // Updated URL for Apple Maps with directions
      urlAppleMaps = 'https://maps.apple.com/?saddr=$origin&daddr=$destination&dirflg=d';
      url = 'comgooglemaps://?saddr=$origin&daddr=$destination&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Future<void> filterMarkers(String id) async {
    print('Filtering markers: $id');
    if (id.isNotEmpty) {
      print('jalan di id not empty');
      //check if there's open panel
      if (panelController.isPanelOpen) {
        _controller.hideMarkerInfoWindow(selectedMarker!.markerId);
        selectedMarker = null;
        panelController.close();
      }

      print('setelah if panelController.isPanelOpen');

      final item = Constants.mapScreenFilterItems
          .firstWhere((element) => element.id == id);
      print('item: $item');
      final type = convertLabelToType(item.label);
      print('type: $type');
      print('item label: ${item.label}');
      selectedChip.value = item.id;
      _markers.value = _createMarkers(_places.where((e) => e.type == type));
    } else {
      print('Resetting markers');
      selectedChip.value = '';
      _markers.value = _createMarkers(_places);
    }
  }

  Set<Marker> _createMarkers(Iterable<PlaceModel> places) {
    return places
        .map((e) => Marker(
              markerId: MarkerId(_generateMarkerId(double.parse(e.latitude), double.parse(e.longitude))),
              position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              infoWindow: InfoWindow(title: e.name, snippet: e.address),
              icon: _getIconForType(e.type),
              onTap: () => onMarkerTapped(Marker(
                markerId: MarkerId(_generateMarkerId(double.parse(e.latitude), double.parse(e.longitude))),
                position: LatLng(double.parse(e.latitude), double.parse(e.longitude)),
              )),
            ))
        .toSet();
  }

  Marker? _createMarker(PlaceModel place) {
    final markerId = _generateMarkerId(double.parse(place.latitude), double.parse(place.longitude));

    return Marker(
      markerId: MarkerId(markerId),
      position: LatLng(double.parse(place.latitude), double.parse(place.longitude)),
      infoWindow: InfoWindow(title: place.name, snippet: place.address),
      icon: _getIconForType(place.type),
      onTap: () => onMarkerTapped(Marker(
        markerId: MarkerId(markerId),
        position: LatLng(double.parse(place.latitude), double.parse(place.longitude)),
      )),
    );
  }

  PlaceDetails convertToPlaceDetails(PlaceModel place, Marker marker) {
    return PlaceDetails(
      name: place.name,
      type: convertTypeName(place.type),
      phoneNumber: place.phone ?? 'N/A',
      position: '${marker.position.latitude}, ${marker.position.longitude}',
      address: place.address ?? '',
    );
  }

  void updatePlaceDetailPanel(PlaceDetails details) {
    placeDetails.value = details;
  }

  void onMarkerTapped(Marker marker) {
    print('Marker tapped: ${marker.markerId.value}');

    // Find the selected place based on the marker ID
    final selectedPlace = _places.firstWhere((e) => _generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == marker.markerId.value);

    // Update the selected place details
    final placeDetails = convertToPlaceDetails(selectedPlace, marker);
    updatePlaceDetailPanel(placeDetails);

    // Update marker icons
    if (selectedMarker != null) {
      print('Reverting selected marker icon');
      _revertMarkerIcon(selectedMarker!.markerId.value);
    }
    _updateMarkerIcon(marker.markerId.value);

    // Check if the tapped marker is already the selected marker
    if (selectedMarker != null && selectedMarker!.markerId == marker.markerId) {
      // Toggle panel state if the same marker is tapped
      if (panelController.isPanelOpen) {
        panelController.close();
        _controller.hideMarkerInfoWindow(marker.markerId);
        _revertMarkerIcon(marker.markerId.value);
        selectedMarker = null;
      } else {
        panelController.open();
      }
    } else {
      // Open panel and set the new selected marker
      selectedMarker = marker;
      panelController.open();
    }

    // Move camera to position marker a bit higher on the screen
    _moveCameraToPosition(marker.position);

    print('Updated selected marker: ${selectedMarker?.markerId.value}');
  }

  void _moveCameraToPosition(LatLng position) {
    final screenHeight = Get.height;
    final panelHeight = 150;
    final latOffset = (panelHeight / screenHeight) * 0.005;

    final targetPosition = LatLng(
      position.latitude - latOffset,
      position.longitude,
    );

    _controller.animateCamera(
      CameraUpdate.newLatLng(targetPosition),
    );
  }

  Future<void> _createCustomMarker() async {
    try {
      gasStation = await _getMarkerIcon("ic_maps_gas_station.png");
      restaurant = await _getMarkerIcon("ic_maps_restaurant.png");
      carDealer = await _getMarkerIcon("ic_maps_dealer.png");
      serviceCenter = await _getMarkerIcon("ic_maps_service_center.png");

      selectedGasStation = await _getMarkerIcon("ic_maps_gas_station_selected.png");
      selectedRestaurant = await _getMarkerIcon("ic_maps_restaurant_selected.png");
      selectedCarDealer = await _getMarkerIcon("ic_maps_dealer_selected.png");
      selectedServiceCenter = await _getMarkerIcon("ic_maps_service_center_selected.png");

      print('Custom markers created successfully');
    } catch (e) {
      print('Error creating custom markers: $e');
    }
  }

  Future<BitmapDescriptor> _getMarkerIcon(String assetName) async {
    final data = await rootBundle.load("assets/icons/$assetName");
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 120);
    final fi = await codec.getNextFrame();
    return BitmapDescriptor.fromBytes((await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List());
  }

  BitmapDescriptor _getIconForType(String type) {
    switch (type) {
      case Constants.TYPE_GAS_STATION:
        return gasStation;
      case Constants.TYPE_RESTAURANT:
        return restaurant;
      case Constants.TYPE_CAR_DEALER:
        return carDealer;
      case Constants.TYPE_SERVICE_CENTER:
        return serviceCenter;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void _updateMarkerIcon(String markerId) {
    final marker = _markers.value.firstWhere((element) => element.markerId.value == markerId);
    final type = _places.firstWhere((e) => _generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == markerId).type;

    final selectedIcon = _getSelectedIconForType(type);
    final updatedMarker = marker.copyWith(iconParam: selectedIcon);

    _markers.value = Set<Marker>.from(_markers.value)
      ..remove(marker)
      ..add(updatedMarker);
  }

  void _revertMarkerIcon(String markerId) {
    final marker = _markers.value.firstWhere((element) => element.markerId.value == markerId);
    final type = _places.firstWhere((e) => _generateMarkerId(double.parse(e.latitude), double.parse(e.longitude)) == markerId).type;

    final icon = _getIconForType(type);
    final revertedMarker = marker.copyWith(iconParam: icon);

    _markers.value = Set<Marker>.from(_markers.value)
      ..remove(marker)
      ..add(revertedMarker);
  }

  BitmapDescriptor _getSelectedIconForType(String type) {
    switch (type) {
      case Constants.TYPE_GAS_STATION:
        return selectedGasStation;
      case Constants.TYPE_RESTAURANT:
        return selectedRestaurant;
      case Constants.TYPE_CAR_DEALER:
        return selectedCarDealer;
      case Constants.TYPE_SERVICE_CENTER:
        return selectedServiceCenter;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

String convertLabelToType(String label) {
  if (label == Constants.LABEL_GAS_STATION) {
    return Constants.TYPE_GAS_STATION;
  } else if (label == Constants.LABEL_CAR_DEALER) {
    return Constants.TYPE_CAR_DEALER;
  } else if (label == Constants.LABEL_RESTAURANT) {
    return Constants.TYPE_RESTAURANT;
  } else if (label == Constants.LABEL_SERVICE_CENTER) {
    return Constants.TYPE_SERVICE_CENTER;
  } else {
    return 'unknown';
  }
}

  String convertTypeName(String type) {
    switch (type) {
      case Constants.TYPE_GAS_STATION:
        return Constants.LABEL_GAS_STATION;
      case Constants.TYPE_RESTAURANT:
        return Constants.LABEL_RESTAURANT;
      case Constants.TYPE_CAR_DEALER:
        return Constants.LABEL_CAR_DEALER;
      case Constants.TYPE_SERVICE_CENTER:
        return Constants.LABEL_SERVICE_CENTER;
      default:
        return 'Unknown';
    }
  }

  String _generateMarkerId(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(6)}_${longitude.toStringAsFixed(6)}';
  }

  void navigateSearch(String? query) async {
    final callback = await Get.toNamed(
      Routes.SEARCH,
      arguments: {'query': query},
    );

    filterMarkers(callback);
  }
}
