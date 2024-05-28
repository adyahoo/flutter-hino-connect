part of 'widgets.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final AppTextFieldShape shape;
  final AppTextFieldState state;
  final String hintText;
  final bool editable;
  final bool canFocus;
  final Function(String? query)? onTap;

  AppSearchBar({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.state,
    this.onTap,
    this.editable = true,
    this.shape = AppTextFieldShape.rounded,
    this.canFocus = true,
  }) : super(key: key);

  void debounceOnChange(String value) {
    var lastClickTime = 0;


    onChanged(value);
  }

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
              debounceOnChange(value);
            },
            onClick: () {
              if (onTap != null) {
                onTap!(controller.text);
              }
            },
          ),
        ),
      ],
    );
  }
}
