part of 'widgets.dart';

enum AppTextFieldType { email, text, password }

class AppTextFieldState {
  final suffixIcon = Rx<IconData>(Iconsax.eye);
  final errorText = Rx<String?>(null);
  final focusNode = FocusNode().obs;
  final isObscure = true.obs;
  final isFocus = false.obs;
  final isError = false.obs;

  void onFocusChange() {
    isFocus.value = focusNode.value.hasFocus;
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;

    if (isObscure.value) {
      suffixIcon.value = Iconsax.eye;
    } else {
      suffixIcon.value = Iconsax.eye_slash;
    }
  }

  void setError(String? errorText) {
    if (errorText != null) {
      isError.value = true;
      this.errorText.value = errorText;
    } else {
      isError.value = false;
      this.errorText.value = null;
    }
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    this.onSaved,
    this.helperText,
    this.isRequired = true,
    this.isEditable = true,
    this.withCounter = false,
    this.isDisabled = false,
  });

  final String label;
  final String placeholder;
  final TextEditingController textEditingController;
  final AppTextFieldState state;
  final AppTextFieldType type;
  final bool isRequired;
  final bool isEditable;
  final bool withCounter;
  final bool isDisabled;
  final Function(String?)? onSaved;
  final String? helperText;

  OutlineInputBorder getBorder(double width, Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Widget _renderSuffixIcon() {
    return InkWell(
      onTap: state.toggleObscure,
      child: Icon(
        state.suffixIcon.value,
        size: 20,
        color: IconColor.secondary,
      ),
    );
  }

  Widget _renderTextField(BuildContext context) {
    return Obx(
      () {
        Color bgColor = Colors.white;
        Color helperColor = TextColor.helper;
        Color borderColor = BorderColor.secondary;
        double borderWidth = 1;

        final isObscure = state.isObscure.value;
        final suffixIcon = (type == AppTextFieldType.password) ? _renderSuffixIcon() : null;

        print("sapi focus $label ${state.isFocus.value} $isDisabled ${state.isError.value}");
        if (state.isError.value) {
          borderColor = BorderColor.error;
          helperColor = TextColor.error;
        } else if (state.isFocus.value && !isDisabled) {
          borderColor = PrimaryColor.focus;
        }

        if (isDisabled) {
          bgColor = BorderColor.secondary;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              focusNode: state.focusNode.value,
              controller: textEditingController,
              onSaved: onSaved,
              readOnly: !isEditable,
              enabled: !isDisabled,
              keyboardType: TextInputType.text,
              maxLines: 1,
              obscureText: (type == AppTextFieldType.password) ? isObscure : false,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  hintText: placeholder,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.placeholder),
                  filled: true,
                  fillColor: bgColor,
                  border: InputBorder.none,
                  focusedBorder: getBorder(3, borderColor),
                  enabledBorder: getBorder(borderWidth, borderColor),
                  errorBorder: getBorder(borderWidth, borderColor),
                  focusedErrorBorder: getBorder(3, borderColor),
                  suffixIcon: suffixIcon,
                  errorStyle: TextStyle(fontSize: 0)),
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) {
                final error = inputValidator(type, value, label);
                state.setError(error);

                if (error != null)
                  return "";
                else
                  return null;
              },
              onChanged: (value) {
                if (state.isError.value) {
                  state.setError(null);
                }
              },
            ),
            (state.isError.value || helperText != null)
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.errorText.value ?? helperText ?? "",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: helperColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      (withCounter)
                          ? Text(
                              "Max. 100 char",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.helper),
                            )
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        _renderTextField(context),
      ],
    );
  }
}
