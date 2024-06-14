part of '../profile.screen.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.point});

  final int point;

  WidgetVariant _getVariant() {
    switch (point) {
      case >= 80:
        return WidgetVariant.success;
      case >= 70 && < 80:
        return WidgetVariant.yellow;
      case >= 40 && < 70:
        return WidgetVariant.warning;
      default:
        return WidgetVariant.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final variant = _getVariant();
    final variantColor = getVariantColor(variant);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: BorderColor.primary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('periode_placeholder'.tr, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            decoration: BoxDecoration(
              color: variantColor.surface, //!REPLACE LATER
              borderRadius: BorderRadius.circular(100), //!CHECK LATER
              border: Border.all(
                color: variantColor.border!, //!REPLACE LATER
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('driver_score_title'.tr, style: Theme.of(context).textTheme.bodyMedium),
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: variantColor.main, // Replace with your actual color
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            'point'.trParams({
                              'poin': point.toString(),
                            }),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: variant == WidgetVariant.yellow ? Colors.black : Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
