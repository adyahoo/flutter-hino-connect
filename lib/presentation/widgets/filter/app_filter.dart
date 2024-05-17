part of '../widgets.dart';

class AppFilter extends GetView<AppFilterController> {
  final List<AppChip> chips;

  AppFilter({Key? key, required this.chips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: chips.map((chip) {
        return GetBuilder<AppChipController>(
          init: AppChipController(),
          builder: (controller) {
            return AppChip(
              label: chip.label,
              icon: chip.icon,
              id: chip.id,
              onSelected: (isSelected) {
                print('Filtering markers by ${chip.id}');
                print('\nisSelected: $isSelected');
                controller.setIsSelected(isSelected);
                if (isSelected) {
                  // Deselect all other chips
                  chips.forEach((otherChip) {
                    if (otherChip.id != chip.id) {
                      var otherController = Get.find<AppChipController>(tag: otherChip.id);
                        if (otherController.isSelected == true) {
                        otherController.setIsSelected(false);
                      }
                    }
                  });
                }
                Get.back();
                // Call the filterMarkers method
                Get.find<MapsController>().filterMarkers(chip.label, isSelected, chip.id);
              },
            );
          },
        );
      }).toList(),
    );
  }
}