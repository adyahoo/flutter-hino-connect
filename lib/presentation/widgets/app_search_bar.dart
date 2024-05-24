part of 'widgets.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final bool editable;
  final TextEditingController controller;
  final AppTextFieldShape shape;
  final hintText;

  AppSearchBar({
    Key? key,
    required this.onSearch,
    this.editable = true,
    required this.controller,
    this.shape = AppTextFieldShape.rounded,
    required this.hintText,
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
            type: AppTextFieldType.search,
            state: AppTextFieldState(),
            isEditable: editable,
            onChanged: (value) {
              print(value);
              onSearch(value);
            },
            onClick: () {
              print('Search');
              editable ? null : Get.toNamed(Routes.SEARCH);
            },
          ),
        ),
      ],
    );
  }
}
