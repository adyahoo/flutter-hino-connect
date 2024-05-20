part of '../home.screen.dart';

class HomeTripList extends GetView<HomeController> {
  const HomeTripList({super.key});

  Widget _renderLoading() {
    return ShimmerContainer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        padding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () {
            if (controller.isFetchingTrip.value) {
              return _renderLoading();
            }

            final trips = controller.todayTrips.value;

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: trips.length,
              itemBuilder: (context, index) => TripCard(trip: trips[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              padding: const EdgeInsets.symmetric(vertical: 0),
            );
          },
        ),
        const SizedBox(height: 16),
        AppButton(
          label: "see_all_trip".tr,
          onPress: () {},
          type: AppButtonType.alternate,
        ),
      ],
    );
  }
}
