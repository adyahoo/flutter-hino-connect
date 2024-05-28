import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class EditProfileController extends GetxController {

  //profile controller
  ProfileController profileController = Get.find();

  //rx user
  var user = UserModel(
    id: 0,
    name: '',
    email: '',
    profilePic: '',
    phoneCode: '',
    phone: '',
  ).obs;

  final picState = AppTextFieldState();
  final emailState = AppTextFieldState();
  final phoneState = AppTextFieldState();
  final fullNameState = AppTextFieldState();
  final picController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();

  final isLoading = false.obs;

  // Future<void> onEditSave() async {
  //   isLoading.value = true;
  //   await Future.delayed(const Duration(seconds: 3));
  //   isLoading.value = false;
  // }

  Future<void> onEditSave() async {
    isLoading.value = true;

    //edit the value from the textfield
    this.user.value = UserModel(
      id: user.value.id,
      name: fullNameController.text,
      email: emailController.text,
      profilePic: picController.text,
      phoneCode: user.value.phoneCode,
      phone: phoneController.text,
    );

    isLoading.value = false;
  }

  //get user
  void getUser() {
    UserModel userData = profileController.data.value;

    this.user.value = userData;
  }

void onEditProfilePic() async {
  final pickedFile = await Get.bottomSheet(
    BsImagePicker(),
  );

  if (pickedFile != null) {
    final isUrl = Uri.tryParse(pickedFile.path)?.hasScheme ?? false;

    if (isUrl) {
      user.update((val) {
        val!.profilePic = pickedFile.path;
      });
    } else {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      
      var userTest = user.value.copyWith(profilePic: base64Image);

      user.value = userTest;
    }
  }
}

  final count = 0.obs;

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

  void increment() => count.value++;
}
