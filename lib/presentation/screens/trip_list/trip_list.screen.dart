import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/trips_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controllers/trip_list.controller.dart';

part 'widgets/trip_card.dart';

part 'widgets/trip_detail_content.dart';

part 'widgets/trip_duration_content.dart';

part 'widgets/trip_penalty_content.dart';

class TripListScreen extends GetView<TripListController> {
  const TripListScreen({Key? key}) : super(key: key);

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }

  void _navigateDetail(TripModel trip) {
    Get.toNamed(
      "/trip-detail/" + trip.id.toString(),
    );
  }

void _showDatePicker(BuildContext context) {
  showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    initialDate: controller.date,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.white, // Header background color
            onPrimary: Colors.black, // Header text color
            onSurface: TextColor.primary, // Default text color
          ),
          dialogBackgroundColor: BackgroundColor.primary, // Background color
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: PrimaryColor.main, // Button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  ).then((pickedDate) {
    if (pickedDate != null && pickedDate != controller.date) {
      controller.setDate(pickedDate);
    }
  });
}

  Widget _renderEmptyTrip(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BackgroundColor.secondary,
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_route_grey.svg",
                  width: 32,
                  height: 32,
                )),
            const SizedBox(height: 24),
            Text(
              'empty_trip_title'.tr,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'empty_trip_subtitle'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderFilterNotFound(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BackgroundColor.secondary,
              ),
              child: Icon(Iconsax.calendar_remove5,
                  size: 32, color: IconColor.secondary),
            ),
            const SizedBox(height: 24),
            Text(
              'trip_not_found_title'.tr,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'trip_not_found_subtitle'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.secondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            AppButton(
              isFullWidth: false,
              label: 'remove_filter'.tr,
              onPress: () {
                controller.clearFilter();
              },
              type: AppButtonType.filled,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "your_trip_list".tr,
        bottom: AppbarBottomPicker(
          textEditingController: controller.filterEditingController.value,
          onTap: () {
            _showDatePicker(context);
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.isFetching.value) {
            return _renderLoading();
          }

          final data = controller.trips.value;
          final entries = data.entries.toList();

          if (entries.isEmpty) {
            if (controller.filterApplied.value) {
              return _renderFilterNotFound(context);
            } else {
              return _renderEmptyTrip(context);
            }
          } else {
            return ListView.builder(
              itemCount: entries.length,
              padding: const EdgeInsets.only(bottom: 16),
              itemBuilder: (context, i) {
                final entry = entries[i];
                final trips = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          entry.key,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: trips.length,
                        itemBuilder: (context, index) => TripCard(
                          trip: trips[index],
                          onTap: _navigateDetail,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

