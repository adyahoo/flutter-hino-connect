import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'controllers/maps.controller.dart';

class MapsScreen extends GetView<MapsController> {
  MapsScreen({Key? key}) : super(key: key);

  final PanelController _panelController = PanelController();
  bool _isRestaurantSelected = false;

  Widget _renderLocationInfo(
      BuildContext context, String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: IconColor.secondary),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        controller: _panelController,
        maxHeight: MediaQuery.of(context).size.height *
            0.4, //!CHANGE LATER IF FOUND THE SOLUTION
        minHeight: 0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        panel: Column(
          children: [
            BsNotch(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SPBU Pertamina 108.803.10',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'POM Bensin',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Container(
                  width: 70,
                  child: AppButton(
                    label: 'Tutup',
                    onPress: () {
                      _panelController.close();
                    },
                    type: AppButtonType.outline,
                    size: AppButtonSize.smallSize,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detail Tempat',
                      style: Theme.of(context).textTheme.labelLarge),
                  SizedBox(height: 16),
                  _renderLocationInfo(context, 'Posisi',
                      '801892839232, 8210930232', Iconsax.location5),
                  SizedBox(height: 16),
                  _renderLocationInfo(
                      context,
                      'Alamat',
                      'Jl. Bypass Ngurah Rai No.6, Jimbaran, Kec. Kuta Sel., Kabupaten Badung, Bali 80361',
                      Iconsax.gps5),
                  SizedBox(height: 16),
                  _renderLocationInfo(
                      context, 'Nomor Telepon', '0361 701000', Iconsax.call5),
                ],
              ),
            )),
          ],
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: controller.fetchPlaces(37.42796133580664, -122.085749655962,
                  'gas_station'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GoogleMap(
                    initialCameraPosition: controller.kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      this.controller.setController(controller);
                    },
                    markers: Set<Marker>.of(controller.markers),
                  );
                } else {
                  return CircularProgressIndicator(); // Show a loading spinner while waiting
                }
              },
            ),

            // GoogleMap(
            //   initialCameraPosition: controller.kGooglePlex,
            //   onMapCreated: (GoogleMapController controller) {
            //     this.controller.setController(controller);
            //     this.controller.fetchPlaces(37.42796133580664, -122.085749655962,
            //         'restaurant');
            //   },
            //   markers: Set<Marker>.of(controller.markers),
            // ),
            Positioned(
              top: Platform.isIOS ? 60.0 : 30.0,
              right: 0.0,
              left: 0.0,
              child: Column(
                children: [
                  AppSearchBar(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          AppChip(
                            label: 'Gas Station',
                            icon: Iconsax.gas_station4,
                            id: 'filter_gas_station',
                            onSelected: () {
                              if (_panelController.isPanelOpen) {
                                _panelController.close();
                              } else {
                                _panelController.open();
                              }
                            },
                          ),
                          SizedBox(width: 8),
                          AppChip(
                            label: 'Dealers',
                            icon: Iconsax.truck,
                            id: 'filter_dealers',
                            onSelected: () {
                              if (_panelController.isPanelOpen) {
                                _panelController.close();
                              } else {
                                _panelController.open();
                              }
                            },
                          ),
                          SizedBox(width: 8),
                          AppChip(
                            label: 'Restaurant',
                            icon: Icons.coffee,
                            id: 'filter_restaurant',
                            onSelected: () {
                              if (_panelController.isPanelOpen) {
                                _panelController.close();
                              } else {
                                _panelController.open();
                              }
                              _isRestaurantSelected = true;
                              double latitude =
                                  37.42796133580664; // replace with actual latitude
                              double longitude =
                                  -122.085749655962; // replace with actual longitude
                              controller.fetchPlaces(
                                  latitude, longitude, 'restaurant');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
