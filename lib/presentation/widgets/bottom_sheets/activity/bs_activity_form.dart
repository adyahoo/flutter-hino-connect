part of '../../widgets.dart';

class BsActivityForm extends GetView<BsActivityFormController> {
  BsActivityForm({super.key});

  final _formKey = GlobalKey<FormState>();

  Widget _renderHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add_activity".tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          "fill_activity_form".tr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.tertiary),
        ),
      ],
    );
  }

  Widget _renderForm() {
    return Obx(
      () => Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              label: 'activity_type'.tr,
              placeholder: 'choose_activity'.tr,
              textEditingController: controller.typeController.value,
              state: controller.typeState,
              type: AppTextFieldType.text,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'activity_type'.tr,
              placeholder: 'choose_activity'.tr,
              textEditingController: controller.typeController.value,
              state: controller.typeState,
              type: AppTextFieldType.text,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'activity_type'.tr,
              placeholder: 'choose_activity'.tr,
              textEditingController: controller.typeController.value,
              state: controller.typeState,
              type: AppTextFieldType.text,
            ),
            const SizedBox(height: 16),
            _renderAction(),
          ],
        ),
      ),
    );
  }

  Widget _renderAction() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          AppButton(
            label: 'cancel'.tr,
            onPress: () {
              Get.back();
            },
            type: AppButtonType.outline,
          ),
          const SizedBox(width: 16),
          AppButton(
            label: 'save'.tr,
            onPress: () {},
            type: AppButtonType.filled,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BsActivityFormController());

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
          BsNotch(),
          const SizedBox(height: 18),
          _renderHeader(context),
          const SizedBox(height: 16),
          _renderForm(),
        ],
      ),
    );
  }
}
