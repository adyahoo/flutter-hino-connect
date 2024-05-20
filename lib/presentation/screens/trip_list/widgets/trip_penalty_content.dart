part of '../trip_list.screen.dart';

class TripPenaltyContent extends StatelessWidget {
  const TripPenaltyContent({super.key, required this.trip});

  final TripModel trip;

  WidgetVariant _getVariant() {
    switch (trip.totalPoint) {
      case <= 10:
        return WidgetVariant.success;
      case >= 11 && <= 30:
        return WidgetVariant.yellow;
      case >= 31 && <= 60:
        return WidgetVariant.warning;
      case >= 61:
        return WidgetVariant.danger;
      default:
        return WidgetVariant.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color labelColor = Colors.white;
    final variant = _getVariant();
    final variantColor = getVariantColor(variant);

    if (variant == WidgetVariant.yellow) {
      labelColor = TextColor.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: variantColor.main,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "penalty_point".trParams(
              {"poin": trip.totalPoint.toString()},
            ),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: labelColor),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: labelColor,
          ),
        ],
      ),
    );
  }
}
