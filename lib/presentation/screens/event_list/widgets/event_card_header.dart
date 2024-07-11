import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({super.key, required this.data});

  final EventModel data;

  @override
  Widget build(BuildContext context) {
    String icon = "ic_truck_remove.svg";

    switch (data.type.value) {
      case "malfunction":
        icon = "ic_truck_remove.svg";
        break;
      case "accident":
        icon = "ic_shield_cross.svg";
        break;
      case "external":
        icon = "ic_security_time.svg";
        break;
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.type.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.formatedDate,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              "assets/icons/$icon",
              width: 40,
              height: 40,
              color: PrimaryColor.main,
            ),
          ],
        ),
      ],
    );
  }
}
