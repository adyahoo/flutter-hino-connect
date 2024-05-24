import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class BsEmergencyContactFormController extends GetxController {
  final nameState = AppTextFieldState();
  final phoneState = AppTextFieldState(inputType: TextInputType.number);

  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final editedId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  ContactModel submit() {
    final data = ContactModel(
      id: editedId.value ?? 100,
      name: nameController.value.text,
      code: "0361",
      phone: phoneController.value.text,
    );

    return data;
  }

  void setInitData(ContactModel initData) {
    editedId.value = initData.id;

    nameController.value.text = initData.name;
    phoneController.value.text = initData.phone;
  }
}
