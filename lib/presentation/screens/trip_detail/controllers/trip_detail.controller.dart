import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/presentation/screens.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _panelController = PanelController();

class TripDetailController extends GetxController {
  late GoogleMapController _controller;

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final panelController = _panelController;

  final currentPanel = TripPanel.detail.obs;
  final panelMaxHeight = 225.0.obs;

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

  void setPanel(TripPanel panel) {
    currentPanel.value = panel;

    switch(currentPanel.value) {
      case TripPanel.detail:
        panelMaxHeight.value = 225;
        break;
      case TripPanel.penalty:
        panelMaxHeight.value = 370;
        break;
    }

    panelController.open();
  }
}
