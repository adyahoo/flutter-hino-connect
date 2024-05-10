import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/picker_model.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class BsActivityFormController extends GetxController {
  final typeState = AppTextFieldState();
  final dateState = AppTextFieldState();
  final timeState = AppTextFieldState();

  final typeController = TextEditingController().obs;
  final dateController = TextEditingController().obs;
  final timeController = TextEditingController().obs;
  final isLoading = false.obs;

  int type = 0;

  void setType(PickerModel value){
    type = value.id;
    typeController.value.text = value.title;
  }

  @override
  void onInit() {
    super.onInit();
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
