import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

class InformationItem extends StatelessWidget {
  const InformationItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/icons/${data['icon']}",
          width: 32,
          height: 32,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            data['content'] as String,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
          ),
        )
      ],
    );
  }
}
