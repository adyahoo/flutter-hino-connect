import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'controllers/maps.controller.dart';

part 'widgets/maps_slide_panel.dart';

class MapsScreen extends GetView<MapsController> {
  MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapsSlidePanel(
        body: Stack(
          children: [
            Obx(
              () => GoogleMap(
                initialCameraPosition: controller.currentCameraPosition,
                markers: {...controller.markers, ...controller.currentMarker.value},
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                compassEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(5, 17),
                onTap: controller.onMapTap,
                onMapCreated: (GoogleMapController controller) {
                  this.controller.setController(controller);
                  this.controller.initMarker(this.controller.currentLocation);
                },
              ),
            ),
            Positioned(
              top: (Platform.isIOS) ? MediaQuery.of(context).viewPadding.top : 8.0 + MediaQuery.of(context).viewPadding.top,
              right: 0.0,
              left: 0.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppSearchBar(
                      hintText: "searchbar_placeholder".tr,
                      controller: controller.searchbarController.value,
                      state: controller.searchBarState,
                      canFocus: false,
                      editable: false,
                      onChanged: (value) {},
                      onTap: (query) {
                        controller.navigateSearch(query);
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppFilter(
                        chips: Constants.mapScreenFilterItems,
                        onClick: (item) {
                          controller.filterMarkers(item);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: (Platform.isIOS) ? kBottomNavigationBarHeight + 80 : kBottomNavigationBarHeight + 40,
              right: 16.0,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: IconButton(
                  onPressed: () {
                    // controller.getCurrentLocation();
                    controller.loadVenueAsCurrentLocation();
                  },
                  splashColor: Colors.white,
                  icon: Icon(Icons.location_searching_outlined, size: 28, color: IconColor.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
