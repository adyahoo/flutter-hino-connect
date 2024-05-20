import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/screens.dart';
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
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                this.controller.initMarker(
                    controller, 37.42796133580664, -122.085749655962);
              },
              markers: controller.markers,
              myLocationButtonEnabled: false,
            ),
          ),
          // MapsSlidePanel(),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  //:TODO: Implement current location
                },
                splashColor: Colors.white,
                icon: Icon(Icons.location_searching_outlined,
                    size: 28, color: IconColor.primary),
              ),
            ),
          ),
          Positioned(
            top: Platform.isIOS ? 60.0 : 30.0,
            right: 0.0,
            left: 0.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppSearchBar(
                    editable: false,
                    onSearch: (value) {
                      print(value);
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppFilter(
                      chips: [
                        AppChip(
                          label: 'Gas Station',
                          icon: Iconsax.gas_station4,
                          id: 'filter_gas_station',
                        ),
                        AppChip(
                          label: 'Dealers',
                          icon: Iconsax.truck,
                          id: 'filter_dealers',
                        ),
                        AppChip(
                          label: 'Restaurant',
                          icon: Icons.coffee,
                          id: 'filter_restaurant',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          MapsSlidePanel(),
        ],
      ),
    );
  }
}