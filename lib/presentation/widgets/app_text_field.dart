part of 'widgets.dart';

enum AppTextFieldType {
  email,
  text,
  password,
  multiline,
  single_picker,
  date_picker,
  time_picker,
  search
}

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
    this.helperText,
    this.isRequired = true,
    this.isEditable = true,
    this.withCounter = false,
    this.isDisabled = false,
  })  : this.onClick = null,
        this.withIcon = false;

  AppTextField.icon({
    super.key,
    required this.label,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    this.helperText,
    this.isRequired = true,
    this.isEditable = true,
    this.withCounter = false,
    this.isDisabled = false,
  })  : this.withIcon = true,
        this.onClick = null;

  AppTextField.picker({
    super.key,
    required this.label,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    required this.onClick,
    this.helperText,
    this.isRequired = true,
    this.isDisabled = false,
  })  : this.withIcon = true,
        this.withCounter = false,
        this.isEditable = false;

  AppTextField.search({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.onClick,
    this.helperText,
    this.isDisabled = false,
  })  : this.withIcon = true,
        this.label = "",
        this.isRequired = false,
        this.placeholder = "",
        this.state = AppTextFieldState(),
        this.withCounter = false,
        this.isEditable = true;

  final String label;
  final String placeholder;
  final TextEditingController textEditingController;
  final AppTextFieldState state;
  final AppTextFieldType type;
  final bool isRequired;
  final bool isEditable;
  final bool withCounter;
  final bool isDisabled;
  final bool withIcon;
  final String? helperText;
  final VoidCallback? onClick;

  OutlineInputBorder getBorder(double width, Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Widget _renderSuffixIcon() {
    IconData? icon;

    switch (type) {
      case AppTextFieldType.password:
        if (state.isObscure.value) {
          icon = Iconsax.eye;
        } else {
          icon = Iconsax.eye_slash;
        }
        break;
      case AppTextFieldType.single_picker:
        icon = Iconsax.arrow_down_1;
        break;
      case AppTextFieldType.date_picker:
        icon = Iconsax.calendar_1;
        break;
      case AppTextFieldType.time_picker:
        icon = Iconsax.clock;
        break;
      case AppTextFieldType.search:
        icon = Icons.search;
        break;
      default:
        icon = null;
        break;
    }

    return InkWell(
      onTap: state.toggleObscure,
      child: Icon(
        icon,
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
        TextInputType inputType = TextInputType.text;
        int maxLines = 1;

        final isObscure = state.isObscure.value;
        final suffixIcon = withIcon ? _renderSuffixIcon() : null;

        if (state.isError.value) {
          borderColor = BorderColor.error;
          helperColor = TextColor.error;
        } else if (state.isFocus.value && !isDisabled) {
          borderColor = PrimaryColor.focus;
        }

        if (isDisabled) {
          bgColor = BorderColor.secondary;
        }

        if (type == AppTextFieldType.multiline) {
          maxLines = 4;
          inputType = TextInputType.multiline;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              focusNode: state.focusNode.value,
              controller: textEditingController,
              onTap: onClick,
              readOnly: !isEditable,
              enabled: !isDisabled,
              keyboardType: inputType,
              maxLines: maxLines,
              obscureText:
                  (type == AppTextFieldType.password) ? isObscure : false,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  hintText: placeholder,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: TextColor.placeholder),
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
                final error = inputValidator(type, value, label, isRequired);
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: helperColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      (withCounter)
                          ? Text(
                              "Max. 100 char",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: TextColor.helper),
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

  Widget _renderSearchTextField(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _renderSuffixIcon(),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari tempat..',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TextColor.placeholder,
                ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (type != AppTextFieldType.search) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: TextColor.secondary),
                ),
                (isRequired)
                    ? TextSpan(
                        text: "*",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.red))
                    : const TextSpan(),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
        (type == AppTextFieldType.search)
            ? _renderSearchTextField(context)
            : _renderTextField(context),
      ],
    );
  }
}
