import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/activities_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:iconsax/iconsax.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.data});

  final ActivityModel data;

  @override
  Widget build(BuildContext context) {
    String icon = "ic_gas_station.svg";

    switch (data.type.value) {
      case "load":
        icon = "ic_document_upload.svg";
        break;
      case "unload":
        icon = "ic_document_download.svg";
        break;
      case "workshop":
        icon = "ic_setting.svg";
        break;
    }

    return Row(
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
    );
  }
}
