part of '../../widgets.dart';

class BsActivityForm extends GetView<BsActivityFormController> {
  BsActivityForm({
    super.key,
    required this.onSubmit,
    this.initialData,
  });

  final Function(ActivityModel data) onSubmit;
  final ActivityModel? initialData;

  final _formKey = GlobalKey<FormState>();

  Widget _renderHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          initialData != null ? "edit_activity".tr : "add_activity".tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        (initialData == null)
            ? Text(
                "fill_activity_form".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: TextColor.tertiary),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _renderForm(BuildContext context) {
    return Obx(
      () => Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField.picker(
              onClick: () {
                _openPicker(context, AppTextFieldType.single_picker);
              },
              label: 'activity_type'.tr,
              placeholder: 'choose_activity'.tr,
              textEditingController: controller.typeController.value,
              state: controller.typeState,
              type: AppTextFieldType.single_picker,
            ),
            const SizedBox(height: 16),
            AppTextField.picker(
              onClick: () {
                _openPicker(context, AppTextFieldType.date_picker);
              },
              label: 'date'.tr,
              placeholder: 'choose_date'.tr,
              textEditingController: controller.dateController.value,
              state: controller.dateState,
              type: AppTextFieldType.date_picker,
            ),
            const SizedBox(height: 16),
            AppTextField.picker(
              onClick: () {
                _openPicker(context, AppTextFieldType.time_picker);
              },
              label: 'time'.tr,
              placeholder: 'choose_time'.tr,
              textEditingController: controller.timeController.value,
              state: controller.timeState,
              type: AppTextFieldType.time_picker,
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
          Expanded(
            child: AppButton(
              label: 'cancel'.tr,
              onPress: () {
                Get.back();
              },
              type: AppButtonType.outline,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppButton(
              label: 'save'.tr,
              onPress: _doSubmit,
              type: AppButtonType.filled,
            ),
          ),
        ],
      ),
    );
  }

  void _openPicker(BuildContext context, AppTextFieldType type) {
    switch (type) {
      case AppTextFieldType.single_picker:
        Get.bottomSheet(
          BsSinglePicker(
            title: 'activity_type'.tr,
            options: Constants.activityTypeItems,
            selectedId: controller.type?.id ?? 0,
            onSubmit: (value) {
              controller.setType(value);
            },
          ),
          isScrollControlled: true,
        );
        break;
      case AppTextFieldType.date_picker:
        showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialDate: controller.date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.white, // Header background color
                  onPrimary: Colors.black, // Header text color
                  onSurface: TextColor.primary, // Default text color
                ),
                dialogBackgroundColor:
                    BackgroundColor.primary, // Background color
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: PrimaryColor.main, // Button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
        ).then((pickedDate) {
          if (pickedDate != null && pickedDate != controller.date) {
            controller.setDate(pickedDate);
          }
        });
        break;
      case AppTextFieldType.time_picker:
        showTimePicker(
          context: context,
          initialTime: controller.time,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.light(
                  primary: PrimaryColor.surface,
                  onBackground: Colors.white,
                  surfaceTint: Colors.transparent,
                ),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.white, // Background color
                  hourMinuteTextColor:
                      TextColor.primary, // Color of the hour and minute numbers
                  dayPeriodTextColor: TextColor.primary, // Color of AM/PM
                  dayPeriodBorderSide: BorderSide(
                      color: PrimaryColor.main), // Border color for AM/PM
                  dialHandColor: PrimaryColor.main, // Color of the hour hand
                  dialTextColor:
                      TextColor.primary, // Text color on the clock dial
                  dialBackgroundColor: PrimaryColor
                      .surface, // Background color of the clock dial
                  entryModeIconColor:
                      TextColor.primary, // Color of the entry mode icon
                  helpTextStyle: const TextStyle(
                    color: TextColor
                        .primary, // Set the text color for "Enter time"
                  ),
                  cancelButtonStyle: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color?>(PrimaryColor.main),
                  ),
                  confirmButtonStyle: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color?>(PrimaryColor.main),
                  ),
                  hourMinuteTextStyle: const TextStyle(fontSize: 30),
                ),
              ),
              child: child!,
            );
          },
        ).then((pickedTime) {
          if (pickedTime != null && pickedTime != controller.time) {
            controller.setTime(pickedTime);
          }
        });
        break;
      default:
        break;
    }
  }

  void _doSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final data = controller.submit();
      onSubmit(data);

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BsActivityFormController());

    if (initialData != null) {
      controller.setInitData(initialData!);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BsNotch(),
            const SizedBox(height: 8),
            _renderHeader(context),
            const SizedBox(height: 16),
            _renderForm(context),
          ],
        ),
      ),
    );
  }
}
