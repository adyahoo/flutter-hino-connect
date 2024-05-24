import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/domain/core/usecases/trip_use_case.dart';
import 'package:hino_driver_app/infrastructure/map_utils.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _panelController = PanelController();

class TripDetailController extends GetxController {
  TripDetailController({required this.tripUseCase});

  final TripUseCase tripUseCase;

  static const originMarkerId = 'originMarkerId';
  static const destinationMarkerId = 'destinationMarkerId';

  late GoogleMapController controller;
  late CameraPosition cameraPosition;
  late BitmapDescriptor originPin;
  late BitmapDescriptor destinationPin;
  late BitmapDescriptor brakePin;
  late BitmapDescriptor overSpeedPin;
  late BitmapDescriptor acceleratePin;
  late BitmapDescriptor lateralAccelPin;
  late BitmapDescriptor brakeSelectedPin;
  late BitmapDescriptor overSpeedSelectedPin;
  late BitmapDescriptor accelerateSelectedPin;
  late BitmapDescriptor lateralAccelSelectedPin;

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});

  Set<Marker> get markers => _markers.value;

  Rx<Set<Polyline>> _polyline = Rx<Set<Polyline>>({});

  Set<Polyline> get polylines => _polyline.value;

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(-8.681547132266411, 115.24069589508952),
    zoom: 16,
  );

  final panelController = _panelController;

  final isFetching = true.obs;
  final currentPanel = TripPanel.detail.obs;
  final panelMaxHeight = 225.0.obs;
  final selectedPenalty = Rx<PenaltyModel?>(null);
  final data = Rx<TripDetailModel?>(null);

  @override
  void onInit() {
    _createCustomMarker();
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

  Future<void> _getData() async {
    isFetching.value = true;
    showLoadingOverlay();

    final detail = await tripUseCase.getTripDetail(int.parse(Get.parameters['id'] ?? "0"));
    data.value = detail;
    await Future.delayed(const Duration(seconds: 2));

    panelController.open();
    hideLoadingOverlay();
    isFetching.value = false;
  }

  void setController(GoogleMapController controller) {
    this.controller = controller;
  }

  void updateCurrentPenalty(String? note) {
    final updatedPenalty = PenaltyModel(
      id: selectedPenalty.value!.id,
      coordinate: selectedPenalty.value!.coordinate,
      type: selectedPenalty.value!.type,
      datetime: selectedPenalty.value!.datetime,
      address: selectedPenalty.value!.address,
      note: note,
    );

    this.selectedPenalty.value = updatedPenalty;

    tripUseCase.updateTripDetail(int.parse(Get.parameters['id'] ?? "0"), updatedPenalty);
  }

  void initRouteMarker() async {
    await _getData();

    _setRoute();
    _markers.value = _createAllMarker();
  }

  void setPanel(TripPanel panel) {
    currentPanel.value = panel;

    switch (currentPanel.value) {
      case TripPanel.detail:
        panelMaxHeight.value = 225;
        break;
      case TripPanel.penalty:
        panelMaxHeight.value = 410;
        break;
    }

    panelController.open();
  }

  void onMapTapped(LatLng latLng) {
    if (selectedPenalty.value != null) {
      _updateSelectedMarker(selectedPenalty.value!, false);
    }

    if (currentPanel.value == TripPanel.penalty) {
      setPanel(TripPanel.detail);
    }
  }

  void _setRoute() async {
    _polyline.value.clear();

    final mapUtils = MapUtils(origin: data.value!.origin, destination: data.value!.destination);
    final coordinates = await mapUtils.getPolyLineRoute();

    final newPolyline = Polyline(
      polylineId: const PolylineId("route"),
      color: InfoNewColor().main,
      width: 6,
      points: coordinates,
    );
    _polyline.value = {newPolyline};
  }

  Set<Marker> _createAllMarker() {
    final createdMarkers = _createOriginDestinationMarker();

    if (data.value!.penalties.isNotEmpty) {
      data.value!.penalties.forEach((e) {
        createdMarkers.add(_createPenaltyMarker(e));
      });
    }

    return createdMarkers;
  }

  Set<Marker> _createOriginDestinationMarker() {
    return {
      Marker(
        markerId: const MarkerId(originMarkerId),
        position: data.value!.origin,
        anchor: const Offset(0.5, 0.5),
        icon: originPin,
      ),
      Marker(
        markerId: const MarkerId(destinationMarkerId),
        position: data.value!.destination,
        anchor: const Offset(0.5, 0.5),
        icon: destinationPin,
      ),
    };
  }

  Marker _createPenaltyMarker(PenaltyModel data, {bool isSelected = false}) {
    BitmapDescriptor icon;
    BitmapDescriptor selectedIcon;

    switch (data.type) {
      case PenaltyType.brake:
        icon = brakePin;
        selectedIcon = brakeSelectedPin;
        break;
      case PenaltyType.over_speed:
        icon = overSpeedPin;
        selectedIcon = overSpeedSelectedPin;
        break;
      case PenaltyType.acceleration:
        icon = acceleratePin;
        selectedIcon = accelerateSelectedPin;
        break;
      case PenaltyType.lateral_accel:
        icon = lateralAccelPin;
        selectedIcon = lateralAccelSelectedPin;
        break;
    }

    return Marker(
      markerId: MarkerId(data.id.toString()),
      position: data.coordinate,
      anchor: const Offset(0.5, 0.5),
      icon: isSelected ? selectedIcon : icon,
      onTap: () {
        _penaltyTapHandler(data);
      },
    );
  }

  void _penaltyTapHandler(PenaltyModel penalty) async {
    final mapUtils = MapUtils(
      origin: penalty.coordinate,
      destination: penalty.coordinate,
    );
    final placemarks = await mapUtils.getAddressFromCoordinate();
    final penaltyData = PenaltyModel(
      id: penalty.id,
      coordinate: penalty.coordinate,
      type: penalty.type,
      datetime: penalty.datetime,
      address: placemarks[0].street,
      note: penalty.note,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      //revert the selected marker into unselected if exist
      if (selectedPenalty.value != null) {
        _updateSelectedMarker(selectedPenalty.value!, false);
      }

      //change marker into selected state
      _updateSelectedMarker(penalty, true);

      //open penalty detail panel
      setPanel(TripPanel.penalty);

      selectedPenalty.value = penaltyData;
    });
  }

  void _updateSelectedMarker(PenaltyModel selected, isSelected) async {
    final selectedMarker = _markers.value.firstWhere(
      (element) => element.markerId.value == selected.id.toString(),
    );
    final newMarker = _createPenaltyMarker(selected, isSelected: isSelected);

    _markers.value = Set<Marker>.from(
      _markers.value.where((element) => element.markerId != selectedMarker.markerId),
    )..add(newMarker);
  }

  void resetMarker() {
    _markers.value.clear();
    _markers.value = {};
  }

  void resetPolyline() {
    _polyline.value.clear();
    _polyline.value = {};
  }

  void resetPanel() {
    panelController.close();
  }

  Future<void> _createCustomMarker() async {
    final originBytes = await _getBytesFromAsset("ic_origin_marker.png", 100);
    originPin = BitmapDescriptor.fromBytes(originBytes);

    final destinationBytes = await _getBytesFromAsset("ic_destination_marker.png", 100);
    destinationPin = BitmapDescriptor.fromBytes(destinationBytes);

    final brakeBytes = await _getBytesFromAsset("ic_brake_marker.png", 100);
    final brakeSelectedBytes = await _getBytesFromAsset("ic_brake_marker_selected.png", 100);
    brakePin = BitmapDescriptor.fromBytes(brakeBytes);
    brakeSelectedPin = BitmapDescriptor.fromBytes(brakeSelectedBytes);

    final overSpeedBytes = await _getBytesFromAsset("ic_over_speed_marker.png", 100);
    final overSpeedSelectedBytes = await _getBytesFromAsset("ic_over_speed_marker_selected.png", 100);
    overSpeedPin = BitmapDescriptor.fromBytes(overSpeedBytes);
    overSpeedSelectedPin = BitmapDescriptor.fromBytes(overSpeedSelectedBytes);

    final accelerateBytes = await _getBytesFromAsset("ic_accelerate_marker.png", 100);
    final accelerateSelectedBytes = await _getBytesFromAsset("ic_accelerate_marker_selected.png", 100);
    acceleratePin = BitmapDescriptor.fromBytes(accelerateBytes);
    accelerateSelectedPin = BitmapDescriptor.fromBytes(accelerateSelectedBytes);

    final lateralAccelBytes = await _getBytesFromAsset("ic_lateral_accel_marker.png", 100);
    final lateralAccelSelectedBytes = await _getBytesFromAsset("ic_lateral_accel_marker_selected.png", 100);
    lateralAccelPin = BitmapDescriptor.fromBytes(lateralAccelBytes);
    lateralAccelSelectedPin = BitmapDescriptor.fromBytes(lateralAccelSelectedBytes);
  }

  Future<Uint8List> _getBytesFromAsset(String assetName, int width) async {
    ByteData data = await rootBundle.load("assets/icons/${assetName}");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
