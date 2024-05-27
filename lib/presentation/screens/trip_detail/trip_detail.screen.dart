import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/app_tag.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'controllers/trip_detail.controller.dart';

part 'widgets/trip_detail_slide_panel.dart';

part 'widgets/detail_panel.dart';

part 'widgets/detail_penalty_panel.dart';

class TripDetailScreen extends GetView<TripDetailController> {
  const TripDetailScreen({Key? key}) : super(key: key);

  Widget _renderBack() {
    return Positioned(
      top: 56,
      left: 16,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TripDetailSlidePanel(
            body: Obx(
              () => GoogleMap(
                initialCameraPosition: controller.kGooglePlex,
                markers: this.controller.markers,
                polylines: this.controller.polylines,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                compassEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(5, 17),
                onTap: this.controller.onMapTapped,
                onMapCreated: (GoogleMapController controller) {
                  this.controller.resetMarker();
                  this.controller.resetPolyline();

                  this.controller.setController(controller);
                  this.controller.initRouteMarker();
                },
              ),
            ),
          ),
          _renderBack(),
        ],
      ),
    );
  }


}
