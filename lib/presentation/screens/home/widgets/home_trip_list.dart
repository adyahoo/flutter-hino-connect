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

  void _navigateDetail(TripModel trip) {
    Get.toNamed(
      "/trip-detail/" + trip.id.toString(),
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

            if (trips.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: BorderColor.primary),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/ic_route.svg",
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'no_today_trip_title'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'no_today_trip_subtitle'.tr,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: trips.length,
                itemBuilder: (context, index) => TripCard(
                  trip: trips[index],
                  onTap: _navigateDetail,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                padding: const EdgeInsets.symmetric(vertical: 0),
              );
            }
          },
        ),
      ],
    );
  }
}
