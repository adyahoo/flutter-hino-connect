part of '../trip_detail.screen.dart';

class DetailPanel extends StatelessWidget {
  const DetailPanel({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "total_penalty_point".tr,
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
