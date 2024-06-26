part of '../maps.screen.dart';

class MapsSlidePanel extends GetView<MapsController> {
  const MapsSlidePanel({required this.body});

  final Widget body;

  Widget _renderLocationInfo(BuildContext context, String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: IconColor.secondary),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.panelController,
      maxHeight: MediaQuery.of(context).size.height * 0.5,
      minHeight: 0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      panel: Column(
        children: [
          BsNotch(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          overflow: TextOverflow.ellipsis,
                          controller.placeDetails.value.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Obx(() => Text(
                          controller.placeDetails.value.type,
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 70,
                child: AppButton(
                  label: 'Tutup',
                  onPress: () {
                    controller.onMarkerTapped(controller.selectedMarker!);
                    controller.panelController.close();
                    // controller.onMarkerTapped(controller.selectedMarker!);
                  },
                  type: AppButtonType.outline,
                  size: AppButtonSize.smallSize,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Detail Tempat', style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(context, 'Posisi', controller.placeDetails.value.position, Iconsax.location5)),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(context, 'Alamat', controller.placeDetails.value.address, Iconsax.gps5)),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(context, 'Nomor Telepon', controller.placeDetails.value.phoneNumber, Iconsax.call5)),
                SizedBox(height: 30),
                AppButton.svgIcon(
                  label: 'see_route'.tr,
                  svgIcon: SvgPicture.asset('assets/icons/ic_navigate_to_route.svg'),
                  onPress: () {
                    controller.handleOpenMaps();
                  },
                  type: AppButtonType.filled,
                ),
              ],
            ),
          )),
        ],
      ),
      body: body,
    );
  }
}
