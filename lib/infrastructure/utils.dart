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

void showGetBottomSheet(Widget content, {bool canExpand = false}) {
  Get.bottomSheet(
    content,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
    isScrollControlled: canExpand,
  );
}
