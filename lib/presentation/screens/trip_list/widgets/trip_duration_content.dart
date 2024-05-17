part of '../trip_list.screen.dart';

class TripDurationContent extends StatelessWidget {
  const TripDurationContent({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 16, left: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: WarningNewColor().surface,
        border: Border.all(width: 1, color: WarningNewColor().border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "trip_duration".tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: WarningNewColor().pressed),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Iconsax.clock5,
            size: 18,
            color: WarningNewColor().pressed,
          ),
          const SizedBox(width: 4),
          Text(
            trip.duration,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WarningNewColor().pressed),
          ),
        ],
      ),
    );
  }
}
