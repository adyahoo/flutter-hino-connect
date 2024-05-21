part of 'widgets.dart';

class AppCardAction extends StatelessWidget {
  const AppCardAction({super.key, required this.onEdit, required this.onDelete});

  final Function() onEdit;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton.icon(
          size: AppButtonSize.smallSize,
          icon: Iconsax.edit_2,
          isFullWidth: false,
          label: "edit".tr,
          onPress: onEdit,
          type: AppButtonType.text,
        ),
        const SizedBox(width: 16),
        AppButton.icon(
          size: AppButtonSize.smallSize,
          icon: Iconsax.trash,
          isFullWidth: false,
          label: "delete".tr,
          onPress: onDelete,
          type: AppButtonType.text,

        ),
      ],
    );
  }
}
