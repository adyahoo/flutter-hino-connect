import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/home.controller.dart';

part 'widgets/home_app_bar.dart';

part 'widgets/home_account_chip.dart';

part 'widgets/home_content_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _renderContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            "vehicle_information".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const HomeContentCard(type: HomeContentType.vehicle),
          const SizedBox(height: 24),
          Text(
            "trip_list".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const HomeContentCard(type: HomeContentType.trip),
          const SizedBox(height: 16),
          AppButton(
            label: "see_all_trip".tr,
            onPress: navigateListTrip,
            type: AppButtonType.alternate,
          )
        ],
      ),
    );
  }

  void navigateListTrip() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppBar(),
          _renderContent(context),
        ],
      ),
    );
  }
}
