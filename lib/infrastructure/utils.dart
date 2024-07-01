import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/entities/api_model.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'dart:math';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

void errorHandler(Exception e, {VoidCallback? onDismiss}) {
  ErrorResponseModel? error;

  print('error: $e');

  if (e is ApiException) {
    print('masuk e is ApiException');
    if (e.response?.error.code == 401) {
      inject<StorageService>().clearToken();
      Get.offAllNamed(Routes.LOGIN);
      return;
    } else if (e.response?.error.code == 422) {
      error = ErrorResponseModel(
        code: 422,
        title: e.response!.error.title,
        message: e.response!.error.message,
      );
    } else {
      if (e.exception!.type == DioExceptionType.connectionError) {
        print('masuk e.connectionError');
        error = ErrorResponseModel(
          code: 500,
          title: 'error_connection'.tr,
          message: 'error_connection_desc'.tr,
          errors: [],
        );
      } else {
        print('masuk else');
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
    }
  } else if (e is PlatformException) {
    error = ErrorResponseModel(
      code: 500,
      title: 'Error Authenticating Biometric',
      message: e.message ?? 'There was an error in authenticating biometric',
      errors: [],
    );
    print('error: $error');
  }

  showGetBottomSheet(
    BsConfirmation(
      type: BsConfirmationType.danger,
      title: error?.title ?? "",
      description: error?.message ?? "",
      isMultiAction: false,
      positiveButtonOnClick: () {
        Get.back();
        onDismiss?.call();
      },
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

void showScanQrBottomSheet(Widget content) {
  Get.bottomSheet(
    content,
    backgroundColor: Colors.white,
    barrierColor: Colors.transparent,
    enableDrag: false,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
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

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  const double earthRadius = 6371000; // meters
  final double dLat = _degreesToRadians(lat2 - lat1);
  final double dLng = _degreesToRadians(lng2 - lng1);
  final double a = sin(dLat / 2) * sin(dLat / 2) + cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLng / 2) * sin(dLng / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

Future<void> showScheduledNewTripNotif() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'schedule_notif_title'.tr,
    'schedule_notif_desc'.trParams({"address": "Hino Denpasar"}),
    tz.TZDateTime.now(tz.local).add(const Duration(minutes: 2)),
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: "@drawable/ic_notif_icon_2",
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
  Future.delayed(const Duration(minutes: 2), () {
    print("sapi trip dorr");
    inject<StorageService>().setScheduleNotifFired();
  });
}

Future<void> showNewTripNotif() async {
  await flutterLocalNotificationsPlugin.show(
    0,
    'schedule_notif_title'.tr,
    'schedule_notif_desc'.trParams({"address": "Hino Denpasar"}),
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: "@drawable/ic_notif_icon_2",
        importance: Importance.high,
        priority: Priority.high,
        color: Colors.red,
      ),
    ),
  );
}

double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x * canvasSize.width / (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width - x * canvasSize.width / (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y * canvasSize.height / (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}
