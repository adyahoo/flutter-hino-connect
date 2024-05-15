part of '../maps.screen.dart';

class MapsSlidePanel extends GetView<MapsController> {
  MapsSlidePanel();

  Widget _renderLocationInfo(
      BuildContext context, String title, String value, IconData icon) {
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
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
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
      maxHeight: MediaQuery.of(context).size.height * 0.4,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.placeName.value,
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  Obx(() => Text(
                        controller.placeType.value,
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ],
              ),
              SizedBox(width: 16),
              Container(
                width: 70,
                child: AppButton(
                  label: 'Tutup',
                  onPress: () {
                    controller.panelController.close();
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
                Text('Detail Tempat',
                    style: Theme.of(context).textTheme.labelLarge),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(context, 'Posisi',
                    controller.position.value.toString(), Iconsax.location5)),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(
                    context, 'Alamat', controller.address.value, Iconsax.gps5)),
                SizedBox(height: 16),
                Obx(() => _renderLocationInfo(context, 'Nomor Telepon',
                    controller.phoneNumber.value, Iconsax.call5)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
