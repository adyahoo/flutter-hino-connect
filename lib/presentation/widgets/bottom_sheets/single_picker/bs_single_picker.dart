part of '../../widgets.dart';

class BsSinglePicker extends GetView<BsSinglePickerController> {
  final List<PickerModel> options;
  final String title;
  final Function(PickerModel value) onSubmit;
  final int selectedId;

  BsSinglePicker({
    Key? key,
    required this.options,
    required this.title,
    required this.selectedId,
    required this.onSubmit,
  }) : super(key: key) {
    Get.put(BsSinglePickerController());
  }

  Widget _renderItem(BuildContext context, PickerModel value) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.setSelectedOption(value.id);
        },
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(
                value.title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
              ),
              trailing: AppRadioButton(
                isSelected: controller.selectedOption.value == value.id,
                onSelect: () {
                  controller.setSelectedOption(value.id);
                },
              ),
            ),
            Divider(color: BorderColor.disabled),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Drag handle
              const BsNotch(),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.secondary),
              ),
              const SizedBox(height: 8),
              ...options.map((PickerModel value) {
                return _renderItem(context, value);
              }).toList(),
              const SizedBox(height: 24),
              AppButton(
                label: "save_change".tr,
                onPress: () {
                  onSubmit(options.firstWhere((element) => element.id == controller.selectedOption.value));
                  Get.back();
                },
                type: AppButtonType.filled,
                isLoading: controller.isFetching.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
