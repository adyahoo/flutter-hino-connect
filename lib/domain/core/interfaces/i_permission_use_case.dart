part of 'i_use_case.dart';

abstract class IPermissionUseCase {
  Future<PermissionStatus?> checkPermission();
}
