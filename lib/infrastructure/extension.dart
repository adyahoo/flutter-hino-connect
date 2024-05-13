import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hino_driver_app/main.dart';

extension RGBA on Color {
  static Color rgba(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
  }
}

extension DateFormatting on DateTime {
  String getActivityDate() {
    final outputFormat = DateFormat("dd MMM yyy").format(this);

    return outputFormat;
  }
}

extension TimeFormatting on TimeOfDay {
  String getActivityTime() {
    return this.format(rootScaffoldMessengerKey.currentState!.context);
  }
}