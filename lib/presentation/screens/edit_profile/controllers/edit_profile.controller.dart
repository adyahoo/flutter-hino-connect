import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/single_picker/controllers/bs_single_picker.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.useCase});

  // Profile controller
  ProfileController profileController = Get.find();

  // User use case
  final UserUseCase useCase;

  // Rx user
  var user = UserModel(
    id: 0,
    name: '',
    email: '',
    profilePic: '',
    phoneCode: '',
    phone: '',
  ).obs;

  // Text field states and controllers
  final picState = AppTextFieldState();
  final emailState = AppTextFieldState();
  final phoneState = AppTextFieldState(inputType: TextInputType.phone);
  final fullNameState = AppTextFieldState();
  final picController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();

  final selectedCode = "62".obs;
  final isLoading = false.obs;
  File? selectedProfilePic;
  var isProfilePicLocal = false.obs; // Flag to check if the profile pic is local

  static const int maxFileSizeInBytes = 2048 * 1024; // 2048 kilobytes

  Future<void> onEditSave() async {
    isLoading.value = true;

    try {
      // Update user details
      final userTest = user.value.copyWith(
        name: fullNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        phoneCode: selectedCode.value,
      );

      await useCase.updateUser(userTest);

      profileController.getUser();
      Get.back();
    } catch (e) {
      Get.bottomSheet(
        BsConfirmation(
          type: BsConfirmationType.danger,
          title: 'Error',
          description: e.toString(),
          isMultiAction: false,
          positiveButtonOnClick: () {
            Get.back();
          },
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get user
  void getUser() {
    UserModel userData = profileController.data.value;
    this.user.value = userData;
    selectedCode.value = userData.phoneCode ?? '62';
  }

  @override
  void onInit() {
    super.onInit();
    getUser();

    fullNameController.text = user.value.name;
    emailController.text = user.value.email;
    phoneController.text = user.value.phone ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
