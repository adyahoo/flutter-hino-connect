import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/dtos/user_dto.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class EditProfileController extends GetxController {
  // final UserModel user;

  // EditProfileController({required this.user});

  //profile controller
  ProfileController profileController = Get.find();

  //rx user
  var user = UserModel(
    id: '',
    name: '',
    email: '',
    role: '',
    status: '',
    profilePic: '',
    score: '',
    phoneCode: '',
    phoneNumber: '',
    createdAt: '',
    updatedAt: '',
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
      role: user.value.role,
      profilePic: picController.text,
      status: user.value.status,
      score: user.value.score,
      phoneCode: user.value.phoneCode,
      phoneNumber: phoneController.text,
      createdAt: user.value.createdAt,
      updatedAt: user.value.updatedAt,
    );

    isLoading.value = false;
    
  }

  //get user
  void getUser() {
    UserModel userData = profileController.data.value;

    print('userData: $userData');

    this.user.value = userData;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUser();
    fullNameController.text = user.value.name;
    emailController.text = user.value.email;
    phoneController.text = user.value.phoneNumber;
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
