part of '../widgets.dart';

class AppFilter extends GetView<AppFilterController> {
  AppFilter({
    Key? key,
    required this.chips,
    required this.onClick,
    this.selectedId,
  }) : super(key: key) {
    Get.put(AppFilterController());
    Get.put(AppChipController());

    if (selectedId != null) {
      controller.setSelectedId(selectedId!);
    }
  }

  final List<MapFilterItem> chips;
  final Function(String id) onClick;
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: chips.map((chip) {
          return AppChip(
            id: chip.id,
            label: chip.label,
            icon: chip.icon,
            selectedId: controller.selectedId.value,
            onSelected: (selectedId) {
              controller.setSelectedId(selectedId);

              onClick(controller.selectedId.value);
            },
          );
        }).toList(),
      ),
    );
  }
}
