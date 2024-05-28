import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/api_model.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

void errorHandler(ApiException e) {
  ErrorResponseModel? error;

  if (e.response?.error.code == 422) {
    error = ErrorResponseModel(
      code: 422,
      title: e.response!.error.title,
      message: e.response!.error.message,
    );
  } else {
    error = ErrorResponseModel(
      code: e.response!.error.code,
      title: e.response!.error.title,
      message: e.response!.error.message,
      errors: e.response!.error.errors
          .map(
            (element) => ErrorModel(
              key: element.key,
              message: element.message,
            ),
          )
          .toList(),
    );
  }

  showGetBottomSheet(
    BsConfirmation(
      type: BsConfirmationType.danger,
      title: error.title,
      description: error.message,
      positiveButtonOnClick: () {},
    ),
  );
}

void showLoadingOverlay() {
  Get.dialog(
    Center(
      child: CircularProgressIndicator(
        color: PrimaryColor.main,
      ),
    ),
    barrierDismissible: false,
  );
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

BaseAppColorProps getVariantColor(WidgetVariant variant) {
  switch (variant) {
    case WidgetVariant.primary:
      return PrimaryNewColor();
    case WidgetVariant.danger:
      return DangerNewColor();
    case WidgetVariant.warning:
      return WarningNewColor();
    case WidgetVariant.success:
      return SuccessNewColor();
    case WidgetVariant.info:
      return InfoNewColor();
    case WidgetVariant.yellow:
      return YellowBaseColor();
  }
}

String formatDate(String date, String destFormat, {String sourceFormat = Constants.DATE_FORMAT_TZ}) {
  DateTime sourceDate = DateFormat(sourceFormat).parse(date);

  return DateFormat(destFormat).format(sourceDate);
}
