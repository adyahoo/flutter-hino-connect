part of '../home.screen.dart';

class HomeVehicleCard extends StatelessWidget {
  const HomeVehicleCard({super.key});

  void showVehicleDetailBS() {
    showGetBottomSheet(BsVehicleDetail());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hino 500 FG 250 TH",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Trailer" + "  ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                          ),
                          TextSpan(
                            text: "\u2022",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: BorderColor.primary,
                                ),
                          ),
                          TextSpan(
                            text: "  " + "DK 10293 FN",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                "assets/icons/ic_truck_fast.svg",
                width: 48,
                height: 48,
              ),
            ],
          ),
          const AppDivider(verticalSpace: 16),
          AppButton(
            label: "see_vehicle_detail".tr,
            onPress: showVehicleDetailBS,
            type: AppButtonType.alternate,
          ),
        ],
      ),
    );
  }
}
