import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/infrastructure/theme/master_color.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: PrimaryColor.main,
  onPrimary: PrimaryColor.content,
  secondary: GrayColor.color10,
  onSecondary: GrayColor.color10,
  error: ErrorColor.main,
  onError: ErrorColor.content,
  background: PrimaryColor.surface,
  onBackground: GrayColor.color100,
  surface: PrimaryColor.surface,
  onSurface: GrayColor.color100,
);

//change this color scheme for dark mode
const darkColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: PrimaryColor.main,
  onPrimary: PrimaryColor.content,
  secondary: GrayColor.color10,
  onSecondary: GrayColor.color10,
  error: ErrorColor.main,
  onError: ErrorColor.content,
  background: PrimaryColor.surface,
  onBackground: GrayColor.color100,
  surface: PrimaryColor.surface,
  onSurface: GrayColor.color100,
);
