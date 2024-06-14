part of '../home.screen.dart';

enum HomeContentType { vehicle, trip }

class HomeContentCard extends StatelessWidget {
  HomeContentCard({
    super.key,
    required this.type,
  });

  final HomeContentType type;

  late HomeController _homeController;

  Widget _renderContent(BuildContext context) {
    String icon;
    String title;
    String subtitle;

    if (type == HomeContentType.vehicle) {
      icon = "ic_scan.svg";
      title = "do_verification_title".tr;
      subtitle = "do_verification_subtitle".tr;
    } else {
      icon = "ic_route.svg";
      title = "no_trip_title".tr;
      subtitle = "no_trip_subtitle".tr;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/icons/$icon",
          width: 48,
          height: 48,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderVehicleContent(BuildContext context) {
    return Column(
      children: [
        _renderContent(context),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const AppDivider(),
        ),
        AppButton.icon(
          icon: Iconsax.scan,
          label: "verification".tr,
          onPress: doVerifyVehicle,
          type: AppButtonType.filled,
        ),
      ],
    );
  }

  Widget _renderTripContent(BuildContext context) {
    return _renderContent(context);
  }

  void doVerifyVehicle() {
    // _homeController.verifyVehicle();
    // Get.toNamed(Routes.FACE_SCAN_INFORMATION);
    showNewTripNotif();
  }

  @override
  Widget build(BuildContext context) {
    _homeController = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: BorderColor.primary),
      ),
      child: (type == HomeContentType.vehicle) ? _renderVehicleContent(context) : _renderTripContent(context),
    );
  }
}
