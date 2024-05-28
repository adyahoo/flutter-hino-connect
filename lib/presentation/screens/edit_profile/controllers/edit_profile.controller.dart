import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/usecases/user_use_case.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';
import 'package:hino_driver_app/presentation/widgets/bottom_sheets/single_picker/controllers/bs_single_picker.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.useCase});

  //profile controller
  ProfileController profileController = Get.find();

  //user use case
  final UserUseCase useCase;

  //rx user
  var user = UserModel(
    id: 0,
    name: '',
    email: '',
    profilePic: '',
    phoneCode: '',
    phone: '',
  ).obs;

  //selected phone code obs
  // var selectedPhoneCode = '+62'.obs;

  final picState = AppTextFieldState();
  final emailState = AppTextFieldState();
  final phoneState = AppTextFieldState();
  final fullNameState = AppTextFieldState();
  final picController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();

  final isLoading = false.obs;

  Future<void> onEditSave() async {
    isLoading.value = true;

    // Get selected phone code from bs single picker
    final selectedId = Get.find<BsSinglePickerController>().selectedOption.value;
    final phoneCode = Get.find<BsSinglePickerController>().items[selectedId].value;

    print('selected id: $selectedId');
    print('phone code: $phoneCode');

    try {
      final userTest = user.value.copyWith(
        name: fullNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        phoneCode: phoneCode,
      );

      await useCase.updateUser(userTest);

      profileController.getUser();
      Get.back();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // //get user
  void getUser() {
    UserModel userData = profileController.data.value;

    this.user.value = userData;
  }

  //get user from use case
  // void getUser() async {
  //   try {
  //     final userTest = await useCase.getUser();
  //     this.user.value = userTest;
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  int getSelectedIdx() {
    final phoneCode = user.value.phoneCode;
    final idx = Constants.countryCodes.indexWhere((element) => element.value == phoneCode);
    return idx;
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
    Get.put(BsSinglePickerController(Constants.countryCodes.obs));
    Get.find<BsSinglePickerController>().setSelectedOption(getSelectedIdx());
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
