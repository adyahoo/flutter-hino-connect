import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:iconsax/iconsax.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Refuel",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                "14 Oktober 2024, 20:30",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          Iconsax.gas_station4,
          size: 40,
          color: PrimaryColor.main,
        )
      ],
    );
  }
}
