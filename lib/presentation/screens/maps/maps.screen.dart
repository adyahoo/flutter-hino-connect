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
  const MapsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
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
                Expanded(
                  
                  child: AppButton(
                      label: 'Tutup',
                      onPress: () {},
                      type: AppButtonType.outline),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Detail Tempat', style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Iconsax.gas_station4, color: IconColor.secondary),
                    SizedBox(width: 8),
                    Text('SPBU', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],)
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                this.controller.setController(controller);
              },
              markers: Set<Marker>.of(<Marker>[]),
            ),
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
                              id: 'filter_gas_station'),
                          SizedBox(width: 8),
                          AppChip(
                              label: 'Dealers',
                              icon: Icons.fire_truck_rounded,
                              id: 'filter_dealers'),
                          SizedBox(width: 8),
                          AppChip(
                              label: 'Restaurant',
                              icon: Icons.coffee,
                              id: 'filter_restaurant'),
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
