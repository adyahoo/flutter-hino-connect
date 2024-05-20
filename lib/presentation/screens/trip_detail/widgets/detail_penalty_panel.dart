part of '../trip_detail.screen.dart';

class DetailPenaltyPanel extends StatelessWidget {
  const DetailPenaltyPanel({
    super.key,
    required this.onBack,
    required this.penalty,
  });

  final VoidCallback onBack;
  final PenaltyModel penalty;

  Widget _renderPenaltyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      penalty.category,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      penalty.address ?? "-",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                "assets/icons/${penalty.icon}",
                width: 32,
                height: 32,
                color: PrimaryNewColor().main,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: AppStrippedDivider(),
          ),
          Text(
            penalty.formattedDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "detail_penalty".tr,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(width: 16),
            AppTag(
              label: "point".trParams(
                {'poin': "4"},
              ),
              variant: WidgetVariant.success,
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppTips(
          content: "tap_penalty_icon".tr,
          variant: WidgetVariant.info,
        ),
        const SizedBox(height: 16),
        _renderPenaltyCard(context),
        const SizedBox(height: 32),
        AppButton(
          label: "back".tr,
          onPress: onBack,
          type: AppButtonType.outline,
        )
      ],
    );
  }
}
