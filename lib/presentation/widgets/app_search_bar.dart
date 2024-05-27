part of 'widgets.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final AppTextFieldShape shape;
  final AppTextFieldState state;
  final String hintText;
  final bool editable;
  final bool canFocus;

  AppSearchBar({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.state,
    this.editable = true,
    this.shape = AppTextFieldShape.rounded,
    this.canFocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField.search(
            placeholder: hintText,
            shape: shape,
            prefixIcon: Icons.search,
            textEditingController: controller,
            state: state,
            canFocus: canFocus,
            isEditable: editable,
            onChanged: (value) {
              onChanged(value);
            },
            onClick: () {
              editable ? null : Get.toNamed(Routes.SEARCH);
            },
          ),
        ),
      ],
    );
  }
}
