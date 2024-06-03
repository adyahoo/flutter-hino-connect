import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/edit_profile.controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'edit_profile'.tr,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: TextColor.primary),
        ),
        backgroundColor: PrimaryColor.content,
        centerTitle: false,
        titleSpacing: 0.0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Title edit profile
                        Text(
                          'photo_profile'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: TextColor.secondary),
                        ),
                        SizedBox(height: 11),
                        
                        // Avatar
                        Obx(() => CircleAvatar(
                              radius: 32,
                              backgroundImage: controller.isProfilePicLocal.value
                                  ? FileImage(File(controller.user.value.profilePic))
                                  : NetworkImage(controller.user.value.profilePic) as ImageProvider,
                            )),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppDivider(),
                      const SizedBox(height: 24),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Full Name
                        AppTextField(
                          label: 'full_name'.tr,
                          placeholder: controller.user.value.name,
                          textEditingController: controller.fullNameController,
                          type: AppTextFieldType.text,
                          state: controller.fullNameState,
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        // Email
                        AppTextField(
                          label: 'Email',
                          placeholder: controller.user.value.email,
                          textEditingController: controller.emailController,
                          type: AppTextFieldType.email,
                          isRequired: true,
                          state: controller.emailState,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'phone'.tr,
                          placeholder: controller.user.value.phone ?? "",
                          textEditingController: controller.phoneController,
                          state: controller.phoneState,
                          type: AppTextFieldType.phoneNumber,
                          isRequired: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                label: 'save_change'.tr,
                onPress: () {
                  controller.onEditSave();
                },
                type: AppButtonType.filled,
                isLoading: controller.isLoading.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

