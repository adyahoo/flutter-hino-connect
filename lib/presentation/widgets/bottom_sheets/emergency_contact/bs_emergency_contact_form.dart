part of '../../widgets.dart';

class BsEmergencyContactForm extends GetView<BsEmergencyContactFormController> {
  BsEmergencyContactForm({required this.onSubmit, this.initData});

  final ContactModel? initData;
  final Function(ContactModel data) onSubmit;

  final _formKey = GlobalKey<FormState>();

  void _doSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final data = controller.submit();
      onSubmit(data);

      Get.back();
    }
  }

  Widget _renderForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            label: 'name'.tr,
            placeholder: 'name_placeholder'.tr,
            textEditingController: controller.nameController.value,
            state: controller.nameState,
            type: AppTextFieldType.text,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'phone'.tr,
            placeholder: 'phone_placeholder'.tr,
            textEditingController: controller.phoneController.value,
            state: controller.phoneState,
            type: AppTextFieldType.phoneNumber,
            isDisabled: true,
          ),
          const SizedBox(height: 16),
          _renderAction(context),
        ],
      ),
    );
  }

  Widget _renderAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              label: "cancel".tr,
              onPress: () {
                Get.back();
              },
              type: AppButtonType.outline,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              label: "save".tr,
              onPress: _doSubmit,
              type: AppButtonType.filled,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BsEmergencyContactFormController());

    if (initData != null) {
      controller.setInitData(initData!);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const BsNotch(),
      const SizedBox(height: 4),
      Obx(
            () =>
        Text(
            (controller.editedId.value != null)
                ? "edit_emergency_contact".tr.capitalizeFirst ?? ""
                : "add_emergency_contact".tr.capitalizeFirst ?? "",
            style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
    const SizedBox(height: 24),
    _renderForm(context),
    ],
    ),
    );
    }
}
