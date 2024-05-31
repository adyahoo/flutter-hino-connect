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
      "/trip-detail/"+ trip.id.toString(),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      initialDate: controller.date,
    ).then((pickedDate) {
      controller.setDate(pickedDate);
    });
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
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: trips.length,
                      itemBuilder: (context, index) => TripCard(
                        trip: trips[index],
                        onTap: _navigateDetail,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
