import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

enum AppTagType { filled, outline, alternate }

enum AppTagSize { small, medium, large }

enum AppTagShape { rounded, rect }

class AppTag extends StatelessWidget {
  AppTag({
    super.key,
    required this.label,
    this.variant = WidgetVariant.primary,
    this.type = AppTagType.filled,
    this.size = AppTagSize.medium,
    this.shape = AppTagShape.rounded,
  });

  final String label;
  final WidgetVariant variant;
  final AppTagType type;
  final AppTagSize size;
  final AppTagShape shape;

  late BuildContext context;

  Color get bgColor {
    final variantColor = getVariantColor(variant);

    if (type == AppTagType.filled) {
      return variantColor.main!;
    } else {
      return variantColor.surface!;
    }
  }

  double get borderRadius {
    if (shape == AppTagShape.rounded) {
      return 24;
    } else {
      return 4;
    }
  }

  Border? get border {
    final variantColor = getVariantColor(variant);

    if (type == AppTagType.outline) {
      return Border.all(width: 1, color: variantColor.main!);
    } else {
      return null;
    }
  }

  TextStyle? get textStyle {
    final variantColor = getVariantColor(variant);
    Color labelColor = variantColor.main!;

    if (type == AppTagType.filled) {
      labelColor = variantColor.content!;
    }

    switch (size) {
      case AppTagSize.small:
        return Theme.of(context).textTheme.labelSmall?.copyWith(color: labelColor);
      case AppTagSize.medium:
        return Theme.of(context).textTheme.labelSmall?.copyWith(color: labelColor);
      case AppTagSize.large:
        return Theme.of(context).textTheme.labelSmall?.copyWith(color: labelColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: Text(
        label,
        style: textStyle,
      ),
    );
  }
}
