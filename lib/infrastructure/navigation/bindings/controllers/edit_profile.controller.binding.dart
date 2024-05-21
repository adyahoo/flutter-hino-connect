import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';

import '../../../../presentation/screens/edit_profile/controllers/edit_profile.controller.dart';

class EditProfileControllerBinding extends Bindings {
  // final UserModel user; 

  // EditProfileControllerBinding({required this.user});

  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}
