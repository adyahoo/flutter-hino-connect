part of '../trip_list.screen.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          TripDetailContent(trip: trip),
          TripDurationContent(trip: trip),
          TripPenaltyContent(trip: trip),
        ],
      ),
    );
  }
}
