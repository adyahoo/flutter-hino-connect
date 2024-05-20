import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/map_utils.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _panelController = PanelController();

class TripDetailController extends GetxController {
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

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});

  Set<Marker> get markers => _markers.value;

  Rx<Set<Polyline>> _polyline = Rx<Set<Polyline>>({});

  Set<Polyline> get polylines => _polyline.value;

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(-8.681547132266411, 115.24069589508952),
    zoom: 16,
  );

  final panelController = _panelController;

  final currentPanel = TripPanel.detail.obs;
  final panelMaxHeight = 225.0.obs;
  final selectedPenalty = Rx<PenaltyModel?>(null);

  final data = Constants.tripDetailData;

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

  void setController(GoogleMapController controller) {
    this.controller = controller;
  }

  void initRouteMarker() {
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
        panelMaxHeight.value = 370;
        break;
    }

    panelController.open();
  }

  void onMapTapped(LatLng latLng) {
    if (currentPanel.value == TripPanel.penalty) {
      setPanel(TripPanel.detail);
    }
  }

  void _setRoute() async {
    _polyline.value.clear();

    final mapUtils = MapUtils(origin: data.origin, destination: data.destination);
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

    if (data.penalties.isNotEmpty) {
      data.penalties.forEach((e) {
        createdMarkers.add(_createPenaltyMarker(e));
      });
    }

    return createdMarkers;
  }

  Set<Marker> _createOriginDestinationMarker() {
    return {
      Marker(
        markerId: const MarkerId(originMarkerId),
        position: data.origin,
        anchor: const Offset(0.5, 0.5),
        icon: originPin,
      ),
      Marker(
        markerId: const MarkerId(destinationMarkerId),
        position: data.destination,
        anchor: const Offset(0.5, 0.5),
        icon: destinationPin,
      ),
    };
  }

  Marker _createPenaltyMarker(PenaltyModel data) {
    BitmapDescriptor icon;

    switch (data.type) {
      case PenaltyType.brake:
        icon = brakePin;
        break;
      case PenaltyType.over_speed:
        icon = overSpeedPin;
        break;
      case PenaltyType.acceleration:
        icon = acceleratePin;
        break;
      case PenaltyType.lateral_accel:
        icon = lateralAccelPin;
        break;
    }

    return Marker(
        markerId: MarkerId(data.id.toString()),
        position: data.coordinate,
        anchor: const Offset(0.5, 0.5),
        icon: icon,
        onTap: () {
          _penaltyTapHandler(data);
        });
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
    );

    selectedPenalty.value = penaltyData;

    Future.delayed(const Duration(milliseconds: 500), () {
      setPanel(TripPanel.penalty);
    });
  }

  Future<void> _createCustomMarker() async {
    final originBytes = await _getBytesFromAsset("ic_origin_marker.png", 100);
    originPin = BitmapDescriptor.fromBytes(originBytes);

    final destinationBytes = await _getBytesFromAsset("ic_destination_marker.png", 100);
    destinationPin = BitmapDescriptor.fromBytes(destinationBytes);

    final brakeBytes = await _getBytesFromAsset("ic_brake_marker.png", 100);
    brakePin = BitmapDescriptor.fromBytes(brakeBytes);

    final overSpeedBytes = await _getBytesFromAsset("ic_over_speed_marker.png", 100);
    overSpeedPin = BitmapDescriptor.fromBytes(overSpeedBytes);

    final accelerateBytes = await _getBytesFromAsset("ic_accelerate_marker.png", 100);
    acceleratePin = BitmapDescriptor.fromBytes(accelerateBytes);

    final lateralAccelBytes = await _getBytesFromAsset("ic_lateral_accel_marker.png", 100);
    lateralAccelPin = BitmapDescriptor.fromBytes(lateralAccelBytes);
  }

  Future<Uint8List> _getBytesFromAsset(String assetName, int width) async {
    ByteData data = await rootBundle.load("assets/icons/${assetName}");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
