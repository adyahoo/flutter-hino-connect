part of 'widgets.dart';

enum TextFieldType { email, text, password }

class AppTextFieldController extends GetxController {
  final prefixIcon = Rx<IconData?>(null);
  bool _isObscure = true;

  void toggleObscure() {
    _isObscure = !_isObscure;

    if (_isObscure) {
      prefixIcon.value = Iconsax.eye;
    } else {
      prefixIcon.value = Iconsax.eye_slash;
    }
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.type = TextFieldType.text,
    this.isRequired = true,
  });

  AppTextField.password({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.type = TextFieldType.password,
    this.isRequired = true,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final TextFieldType type;
  final bool isRequired;

  bool isObscure = false;

  Widget _renderTextField(BuildContext context, Color bgColor, Widget? suffixIcon) {
    return TextFormField(
      // focusNode: _focusNode,
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      obscureText: (type == TextFieldType.password) ? isObscure : false,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.placeholder),
        // filled: true,
        // fillColor: bgColor,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: bgColor),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      // validator: (value) {
      //   final isValid = inputValidator(type, value, label);
      //
      //   setState(() {
      //     isError = isValid != null;
      //   });
      //
      //   return isValid;
      // },
      // onSaved: onSaved,
      // readOnly: !isEditable,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = BorderColor.secondary;
    Widget? suffixIcon;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.secondary),
              ),
              (isRequired) ? TextSpan(text: "*", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.red)) : const TextSpan(),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _renderTextField(context, bgColor, suffixIcon),
      ],
    );
  }
}
