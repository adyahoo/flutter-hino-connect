part of '../widgets.dart';

class AppChip extends GetView<AppChipController> {
  final String id;
  final String label;
  final Widget icon;
  final Function(String id)? onSelected;
  final String? selectedId;

  AppChip({
    Key? key,
    required this.label,
    required this.icon,
    required this.id,
    this.onSelected,
    this.selectedId,
  }) : super(key: key) {
    if (selectedId != null) {
      controller.setIsSelected(selectedId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.setIsSelected(id);

              if (onSelected != null) {
                onSelected!(id);
              }
            },
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              avatar: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  controller.selectedId.value == id
                      ? PrimaryColor.main
                      : IconColor.secondary,
                  BlendMode.srcIn,
                ),
                child: icon,
              ),
              label: Text(
                label,
                style: TextStyle(
                  color: controller.selectedId.value == id
                      ? PrimaryColor.main
                      : Colors.black,
                ),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                side: BorderSide(
                  color: controller.selectedId.value == id
                      ? PrimaryColor.main
                      : BorderColor.secondary,
                  width: 1,
                ),
              ),
              backgroundColor: controller.selectedId.value == id
                  ? PrimaryColor.surface
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
