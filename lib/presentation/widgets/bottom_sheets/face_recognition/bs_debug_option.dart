part of '../../widgets.dart';

class BsDebugOption extends StatelessWidget {
  const BsDebugOption({super.key, required this.onTapOption});

  final VoidCallback onTapOption;

  Widget _renderContent(BuildContext context) {
    return AppOptionCard(
      title: "force_vehicle_title".tr,
      description: "force_vehicle_description".tr,
      onTap: onTapOption,
      prefix: SvgPicture.asset(
        "assets/icons/ic_truck_tick.svg",
        width: 32,
        height: 32,
      ),
      suffix: Icon(
        Icons.chevron_right_rounded,
        size: 16,
        color: GrayColor.color90,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BsNotch(),
          const SizedBox(height: 10),
          Text(
            "debug_option".tr,
            style: context.textTheme.titleLarge?.copyWith(color: TextColor.secondary),
          ),
          const SizedBox(height: 24),
          // Main description content
          _renderContent(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
