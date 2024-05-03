import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_text_theme.dart';
import 'package:hino_driver_app/infrastructure/theme/color_scheme.dart';

class AppTheme {
  static ThemeData getLightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: AppTextTheme.getTextTheme(),
      );
}
