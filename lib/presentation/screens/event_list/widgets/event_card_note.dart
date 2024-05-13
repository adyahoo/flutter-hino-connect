import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';

class EventCardNote extends StatelessWidget {
  const EventCardNote({super.key, required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const AppStrippedDivider(),
        ),
        Row(
          children: [
            Icon(
              Iconsax.flag,
              size: 16,
              color: IconColor.secondary,
            ),
            const SizedBox(width: 4),
            Text(
              note,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
