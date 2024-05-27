import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/edit_profile.controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
                        //title edit profile
                        Text(
                          'Foto Profil',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: TextColor.secondary),
                        ),
                        SizedBox(height: 11),
                        // Avatar
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            user.profilePic,
                          ), //!PLEASE CHANGE LATER BASED ON THE IMAGE API
                        ),
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
                          label: 'Full Name',
                          placeholder: user.name,
                          textEditingController: controller.fullNameController,
                          type: AppTextFieldType.text,
                          state: controller.fullNameState,
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        // Email
                        AppTextField(
                          label: 'Email',
                          placeholder: user.email,
                          textEditingController: controller.emailController,
                          type: AppTextFieldType.email,
                          isRequired: true,
                          state: controller.emailState,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'Phone Number',
                          placeholder: user.phone??"",
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
                label: 'Save Changes',
                onPress: controller.onEditSave,

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
