import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

class AppTextTheme {
  AppTextTheme._();

  static final _baseTheme = GoogleFonts.instrumentSans().copyWith(color: TextColor.primary, fontWeight: FontWeight.w600);

  static TextTheme getTextTheme() => TextTheme(
        headlineLarge: _baseTheme.copyWith(fontSize: 32),
        headlineMedium: _baseTheme.copyWith(fontSize: 28),
        headlineSmall: _baseTheme.copyWith(fontSize: 24),
        titleLarge: _baseTheme.copyWith(fontSize: 20),
        titleMedium: _baseTheme.copyWith(fontSize: 18),
        titleSmall: _baseTheme.copyWith(fontSize: 16),
        labelLarge: _baseTheme.copyWith(fontSize: 14),
        labelMedium: _baseTheme.copyWith(fontSize: 12),
        labelSmall: _baseTheme.copyWith(fontSize: 10),
        bodyLarge: _baseTheme.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: _baseTheme.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: _baseTheme.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      );
}
