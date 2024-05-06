import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void doLogin() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: Stack(
        children: [
          Positioned(
            right: -6,
            bottom: 0,
            left: -6,
            child: SvgPicture.asset(
              "assets/images/login_illust.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/logo.svg",
                      width: 170,
                      height: 34,
                    ),
                  ),
                  const SizedBox(height: 56),
                  Text(
                    'login_title'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'login_subtitle'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          label: 'Email',
                          placeholder: 'email_placeholder'.tr,
                          textEditingController: controller.emailController.value,
                          state: controller.emailState,
                          type: AppTextFieldType.email,
                        ),
                        const SizedBox(height: 28),
                        AppTextField(
                          label: 'password'.tr,
                          placeholder: 'password_placeholder'.tr,
                          textEditingController: controller.passwordController.value,
                          state: controller.passwordState,
                          type: AppTextFieldType.password,
                        ),
                        const SizedBox(height: 28),
                        AppButton(
                          type: AppButtonType.filled,
                          label: 'login'.tr,
                          onPress: doLogin,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
