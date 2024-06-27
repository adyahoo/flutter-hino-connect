part of '../../widgets.dart';

class BsCountryPicker extends GetView<BsCountryPickerController> {
  final Function(CountryModel value) onSubmit;
  final String selectedId;

  BsCountryPicker({
    Key? key,
    required this.selectedId,
    required this.onSubmit,
  }) : super(key: key) {
    Get.put(BsCountryPickerController(useCase: inject()));
    controller.setSelectedOption(selectedId);
  }

  Widget _renderItem(BuildContext context, CountryModel value) {
    return Obx(
      () => ListTile(
        onTap: () {
          controller.setSelectedOption(value.phoneCode);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: SizedBox(
          width: 24,
          height: 24,
          child: CircleAvatar(
            backgroundImage: NetworkImage(value.flag),
          ),
        ),
        title: Text(
          "+${value.phoneCode} ${value.name}",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
        ),
        trailing: AppRadioButton(
          isSelected: controller.selectedId.value == value.phoneCode,
          onSelect: () {
            controller.setSelectedOption(value.phoneCode);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const BsNotch(),
          const SizedBox(height: 8),
          Text(
            'country_code'.tr,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.secondary),
          ),
          const SizedBox(height: 10),
          AppSearchBar(
            hintText: 'searchbar_phonecode_placeholder'.tr,
            shape: AppTextFieldShape.rect,
            controller: controller.searchController,
            state: controller.searchState,
            onChanged: (value) {
              controller.search(value);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final items = controller.filteredItems.value;

              return ListView.separated(
                itemCount: items.length,
                itemBuilder: (context, index) => _renderItem(context, items[index]),
                separatorBuilder: (context, index) => const Divider(color: BorderColor.disabled),
              );
            }),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: AppButton(
              label: "save_change".tr,
              onPress: () {
                final selected = controller.getSelectedItem();

                onSubmit(selected);
                Get.back();
              },
              type: AppButtonType.filled,
              isLoading: controller.isFetching.value,
            ),
          ),
        ],
      ),
    );
  }
}
