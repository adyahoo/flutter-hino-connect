import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
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

  String formatDate(String destFormat, {String sourceFormat = Constants.DATE_FORMAT_TZ}) {
    final locale = Get.locale.toString();

    return DateFormat(destFormat, locale).format(this);
  }
}

extension StringDateFormatting on String {
  String formatDateFromString(String destFormat, {String sourceFormat = Constants.DATE_FORMAT_TZ}) {
    final locale = Get.locale.toString();
    DateTime sourceDate = DateFormat(sourceFormat).parse(this);

    return DateFormat(destFormat, locale).format(sourceDate);
  }
}

extension TimeFormatting on TimeOfDay {
  String getActivityTime() {
    return this.format(rootScaffoldMessengerKey.currentState!.context);
  }
}