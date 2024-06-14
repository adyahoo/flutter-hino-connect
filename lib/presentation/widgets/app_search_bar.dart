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
  final Function()? onClear;

  AppSearchBar({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.state,
    this.onClear,
    this.onTap,
    this.editable = true,
    this.shape = AppTextFieldShape.rounded,
    this.canFocus = true,
  }) : super(key: key);

  Timer? _debounce;

  void debounceOnChange(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      onChanged(value);
    });
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
            onChanged: debounceOnChange,
            onClear: onClear,
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
