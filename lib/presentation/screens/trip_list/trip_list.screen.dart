import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/main.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/trip_list.controller.dart';

part 'widgets/trip_card.dart';
part 'widgets/trip_detail_content.dart';
part 'widgets/trip_duration_content.dart';
part 'widgets/trip_penalty_content.dart';

class TripListScreen extends GetView<TripListController> {
  const TripListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "your_trip_list".tr,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
