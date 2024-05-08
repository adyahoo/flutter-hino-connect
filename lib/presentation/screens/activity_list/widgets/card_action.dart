import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class CardAction extends StatelessWidget {
  const CardAction({super.key, required this.onEdit, required this.onDelete});

  final Function() onEdit;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton.icon(
          icon: Iconsax.edit_2,
          isFullWidth: false,
          label: "edit".tr,
          onPress: onEdit,
          type: AppButtonType.text,
        ),
        const SizedBox(width: 16),
        AppButton.icon(
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
