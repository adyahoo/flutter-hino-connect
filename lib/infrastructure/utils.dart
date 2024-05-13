import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

void showLoadingOverlay() {
  Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: PrimaryColor.main,
        ),
      ),
      barrierDismissible: false);
}

void hideLoadingOverlay() {
  Get.back();
}
