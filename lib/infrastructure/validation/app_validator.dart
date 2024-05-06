import 'package:get/get.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

String? inputValidator(AppTextFieldType type, String? value, String label) {
  if (value == null || value.trim().isEmpty) {
    return "error_required".trParams({
      'label': label,
    });
  }

  switch (type) {
    case AppTextFieldType.text:
      break;
    case AppTextFieldType.password:
      if (!GetUtils.isLengthBetween(value, 6, 12)) {
        return "error_password_invalid".tr;
      }
      break;
    case AppTextFieldType.email:
      if (!GetUtils.isEmail(value)) {
        return "error_email_invalid".tr;
      }
      break;
  }

  return null;
}
