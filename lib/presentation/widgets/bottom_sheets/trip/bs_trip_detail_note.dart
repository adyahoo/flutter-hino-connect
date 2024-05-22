part of '../../widgets.dart';

class BsTripDetailNote extends StatelessWidget {
  const BsTripDetailNote({super.key, required this.onSave, this.note});

  final Function(String? note) onSave;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController(text: note != null ? note : null);

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
          const SizedBox(height: 8),
          Text(
            note != null ? "edit_note".tr : "add_note".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: "note".tr,
            placeholder: "note_trip_placeholder".tr,
            textEditingController: editController,
            state: AppTextFieldState(),
            type: AppTextFieldType.text,
            isRequired: false,
            length: 50,
          ),
          const SizedBox(height: 16),
          Padding(
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
                    onPress: () {
                      onSave(editController.text);
                      Get.back();
                    },
                    type: AppButtonType.filled,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
