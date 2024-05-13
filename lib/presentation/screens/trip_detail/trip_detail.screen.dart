import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controllers/trip_detail.controller.dart';

class TripDetailScreen extends GetView<TripDetailController> {
  const TripDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripDetailScreen'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: controller.kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          this.controller.setController(controller);
        },
      ),
    );
  }
}
