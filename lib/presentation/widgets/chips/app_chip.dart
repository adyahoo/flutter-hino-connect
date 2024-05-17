part of '../widgets.dart';

class AppChip extends GetView<AppChipController> {
  final String label;
  final IconData icon;
  final String id;
  final Function(bool)? onSelected;

  AppChip({
    Key? key,
    required this.label,
    required this.icon,
    required this.id,
    this.onSelected,
  }) : super(key: key) {
    Get.put(AppChipController(), tag: id);
  }

  @override
  Widget build(BuildContext context) {
    final AppChipController controller = Get.find(tag: id);
    return Row(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.setIsSelected(!controller.isSelected.value);
              if (onSelected != null) {
                onSelected!(controller.isSelected.value); 
              }
            },
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              avatar: Icon(icon, color: controller.isSelected.value ? PrimaryColor.main: IconColor.secondary, size: 16),
              label: Text(label, style: TextStyle(color: controller.isSelected.value ? PrimaryColor.main: Colors.black)),
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                side: BorderSide(
                  color: controller.isSelected.value ? PrimaryColor.main : BorderColor.secondary,
                  width: 1,
                ),
              ),
              backgroundColor: controller.isSelected.value ? PrimaryColor.surface : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}