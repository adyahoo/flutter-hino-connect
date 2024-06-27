part of '../trip_list.screen.dart';

class TripDetailContent extends StatelessWidget {
  const TripDetailContent({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 96,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_blue_circle.svg",
                  width: 12,
                  height: 12,
                ),
                SizedBox(
                  height: 52,
                  child: const AppStrippedDivider(direction: AppDividerDirection.vertical),
                ),
                SvgPicture.asset(
                  "assets/icons/ic_orange_circle.svg",
                  width: 12,
                  height: 12,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.origin.address,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "started_at".tr + " ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.tertiary),
                      ),
                      TextSpan(
                        text: trip.origin.formattedDate,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  trip.destination.address,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "ended_at".tr + " ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.tertiary),
                      ),
                      TextSpan(
                        text: trip.destination.formattedDate,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                trip.totalDistance.toString(),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TextColor.secondary),
              ),
              Text(
                "KM",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
