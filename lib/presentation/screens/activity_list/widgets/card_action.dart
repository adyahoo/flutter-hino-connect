import 'package:flutter/material.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class CardAction extends StatelessWidget {
  const CardAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton.icon(
          icon: Iconsax.edit_2,
          isFullWidth: false,
          label: "Ubah",
          onPress: () {},
          type: AppButtonType.text,
        ),
        const SizedBox(width: 16),
        AppButton.icon(
          icon: Iconsax.trash,
          isFullWidth: false,
          label: "Ubah",
          onPress: () {},
          type: AppButtonType.text,
        ),
      ],
    );
  }
}
