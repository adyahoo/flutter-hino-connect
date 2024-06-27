import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/screens.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/home.controller.dart';

part 'widgets/home_app_bar.dart';
part 'widgets/home_account_chip.dart';
part 'widgets/home_content_card.dart';
part 'widgets/home_vehicle_card.dart';
part 'widgets/home_trip_list.dart';
part 'bs/bs_vehicle_detail.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _renderContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "vehicle_information".tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            (controller.isVehicleVerified.value)
                ? HomeVehicleCard()
                : HomeContentCard(type: HomeContentType.vehicle),
            const SizedBox(height: 24),
            Text(
              "today_trip".tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            (controller.isVehicleVerified.value)
                ? HomeTripList()
                : HomeContentCard(type: HomeContentType.trip),
            const SizedBox(height: 16),
            AppButton(
              label: "see_all_trip".tr,
              onPress: () {
                Get.toNamed(Routes.TRIP_LIST);
              },
              type: AppButtonType.alternate,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void navigateListTrip() {
    Get.toNamed(Routes.TRIP_LIST);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xffD9565B), 
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBar(),
              _renderContent(context),
            ],
          ),
        ),
      ),
    );
  }
}
