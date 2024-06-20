part of '../home.screen.dart';

class BsVehicleDetail extends StatelessWidget {
  const BsVehicleDetail({super.key});

  Widget _renderItem(BuildContext context, String label, String item) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            item,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 24, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BsNotch(),
          Text(
            "vehicle_detail".tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.secondary),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: BorderColor.primary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: SvgPicture.asset(
                          "assets/icons/ic_truck_fast.svg",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      TextSpan(
                        text: " " + "Hino Bus GB150 - Euro4",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TextColor.secondary),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "scanned".tr + " ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                      ),
                      TextSpan(
                        text: "27 Agustus 2024, 20:30",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.secondary),
                      ),
                    ],
                  ),
                ),
                const AppDivider(),
                _renderItem(context, "Body", "Bus"),
                const AppDivider(),
                _renderItem(context, "plat_number".tr, "B 9988 XYZ"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
