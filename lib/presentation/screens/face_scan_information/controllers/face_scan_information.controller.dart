import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/usecases/permission_use_case.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceScanInformationController extends GetxController {
  FaceScanInformationController({required this.permissionUseCase});

  final PermissionUseCase permissionUseCase;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkPermission() async {
    final result = await permissionUseCase.checkPermission();

    switch (result) {
      case PermissionStatus.denied:
        showGetBottomSheet(
          BsConfirmation(
            type: BsConfirmationType.danger,
            title: "permission_denied_title".tr,
            description: "permission_denied_desc".tr,
            isMultiAction: false,
            positiveButtonOnClick: () {
              Get.back();
            },
          ),
        );
      case PermissionStatus.permanentlyDenied:
        showGetBottomSheet(
          BsConfirmation(
            type: BsConfirmationType.danger,
            title: "permission_permanent_denied_title".tr,
            description: "permission_permanent_denied_desc".tr,
            positiveTitle: "go_to_setting".tr,
            negativeTitle: "back".tr,
            positiveButtonOnClick: () {
              Get.back();

              openAppSettings();
            },
          ),
        );
      case PermissionStatus.granted:
        Get.toNamed(Routes.FACE_RECOGNITION);
        break;
      default:
        break;
    }
  }

  void navigateFaceRecog() {
    _checkPermission();
  }
}
