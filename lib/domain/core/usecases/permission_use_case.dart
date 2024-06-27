import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUseCase implements IPermissionUseCase {
  @override
  Future<PermissionStatus?> checkPermission() async {
    final permissions = [Permission.camera, Permission.microphone];
    if (Platform.isAndroid) {
      final androidInfor = await DeviceInfoPlugin().androidInfo;
      final sdkVersion = androidInfor.version.sdkInt;

      if (sdkVersion >= 34) {
        permissions.add(Permission.scheduleExactAlarm);
      }
    }

    final result = await permissions.request();
    PermissionStatus status = PermissionStatus.granted;

    result.forEach((key, value) {
      switch (value) {
        case PermissionStatus.denied:
          status = PermissionStatus.denied;
          break;
        case PermissionStatus.permanentlyDenied:
          status = PermissionStatus.permanentlyDenied;
          break;
        default:
          status = PermissionStatus.granted;
          break;
      }
    });

    return status;
  }
}
