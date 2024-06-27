part of '../trip_detail.screen.dart';

class DetailPenaltyPanel extends StatelessWidget {
  const DetailPenaltyPanel({
    super.key,
    required this.onBack,
    required this.penalty,
    required this.onUpdateNote,
  });

  final VoidCallback onBack;
  final PenaltyModel penalty;
  final Function(String? note) onUpdateNote;

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
                    const SizedBox(height: 4),
                    Text(
                      penalty.formattedDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Iconsax.flag,
                size: 16,
                color: IconColor.secondary,
              ),
              const SizedBox(width: 4),
              Text(
                penalty.note ?? "no_note".tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: AppStrippedDivider(),
          ),
          AppButton.icon(
            icon: penalty.note != null ? Iconsax.edit_2 : Iconsax.add,
            isFullWidth: false,
            label: penalty.note != null ? "edit_note".tr : "add_note".tr,
            onPress: _showNoteBs,
            size: AppButtonSize.smallSize,
            type: AppButtonType.text,
          ),
        ],
      ),
    );
  }

  void _showNoteBs() {
    showGetBottomSheet(
      BsTripDetailNote(
        note: penalty.note,
        onSave: onUpdateNote,
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
                {'poin': (penalty.penaltyPoint == 0) ? "0" : "+${penalty.point}"},
              ),
              variant: WidgetVariant.success,
            ),
          ],
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
