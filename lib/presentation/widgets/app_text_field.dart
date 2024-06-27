part of 'widgets.dart';

enum AppTextFieldType { email, text, password, multiline, single_picker, date_picker, time_picker, search, phoneNumber }

enum AppTextFieldShape { rect, rounded }

enum AppFormActionType { add, edit }

class AppTextFieldState {
  AppTextFieldState({
    this.inputType = TextInputType.text,
    this.maxLines = 1,
  });

  final TextInputType inputType;
  final int maxLines;

  final errorText = Rx<String?>(null);
  final focusNode = FocusNode().obs;
  final isObscure = true.obs;
  final isFocus = false.obs;
  final isError = false.obs;

  void onFocusChange() {
    isFocus.value = focusNode.value.hasFocus;
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

  AppTextFieldState copyWith({
    TextInputType? inputType,
    int? maxLines,
  }) {
    return AppTextFieldState(
      inputType: inputType ?? this.inputType,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    this.label,
    this.onTapPrefix,
    this.helperText,
    this.onChanged,
    this.prefixIcon,
    this.shape = AppTextFieldShape.rect,
    this.isRequired = true,
    this.isEditable = true,
    this.isDisabled = false,
    this.length = null,
  })  : this.onClick = null,
        this.canFocus = true,
        this.onClear = null,
        this.suffixIcon = false;

  AppTextField.icon({
    super.key,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    this.label,
    this.onTapPrefix,
    this.helperText,
    this.onChanged,
    this.prefixIcon,
    this.shape = AppTextFieldShape.rect,
    this.isRequired = true,
    this.isEditable = true,
    this.isDisabled = false,
    this.length = null,
  })  : this.suffixIcon = true,
        this.canFocus = true,
        this.onClear = null,
        this.onClick = null;

  AppTextField.picker({
    super.key,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    required this.onClick,
    this.label,
    this.onChanged,
    this.helperText,
    this.prefixIcon,
    this.onTapPrefix,
    this.shape = AppTextFieldShape.rect,
    this.isRequired = true,
    this.isDisabled = false,
  })  : this.suffixIcon = true,
        this.length = null,
        this.canFocus = true,
        this.onClear = null,
        this.isEditable = false;

  AppTextField.search({
    super.key,
    required this.textEditingController,
    required this.onClick,
    required this.state,
    required this.onChanged,
    required this.onClear,
    this.label,
    this.helperText,
    this.onTapPrefix = null,
    this.prefixIcon,
    this.isDisabled = false,
    this.isEditable = true,
    this.shape = AppTextFieldShape.rounded,
    this.placeholder = 'Search',
    this.canFocus = true,
  })  : this.suffixIcon = true,
        this.type = AppTextFieldType.search,
        this.isRequired = false,
        this.length = null;

  AppTextField.phoneNumber({
    super.key,
    required this.textEditingController,
    required this.state,
    required this.onTapPrefix,
    required this.phoneCode,
    this.onChanged,
    this.label,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon = false,
    this.isEditable = true,
    this.shape = AppTextFieldShape.rect,
    this.placeholder = 'Phone Number',
    this.isRequired = false,
    this.canFocus = true,
  })  : this.isDisabled = false,
        this.type = AppTextFieldType.phoneNumber,
        this.onClick = null,
        this.onClear = null,
        this.length = null;

  final String placeholder;
  final TextEditingController textEditingController;
  final AppTextFieldState state;
  final AppTextFieldType type;
  final AppTextFieldShape shape;
  final bool isRequired;
  final bool isEditable;
  final bool isDisabled;
  final bool canFocus;
  final String? label;
  final int? length;
  final bool suffixIcon;
  final IconData? prefixIcon;
  final String? helperText;
  final VoidCallback? onClick;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final Function(dynamic data)? onTapPrefix;

  String phoneCode = "62";

  OutlineInputBorder getBorder(double width) {
    Color borderColor = BorderColor.secondary;
    double radius = (shape == AppTextFieldShape.rect) ? 8 : 24;

    if (type == AppTextFieldType.search) {
      radius = 24;
    }

    if (state.isError.value) {
      borderColor = BorderColor.error;
    } else if (state.isFocus.value && !isDisabled) {
      borderColor = PrimaryColor.focus;
    }

    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: borderColor),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  OutlineInputBorder getFocusedBorder() {
    double width = 3;
    double radius = (shape == AppTextFieldShape.rect) ? 8 : 24;
    Color borderColor = BorderColor.secondary;

    if (type == AppTextFieldType.search) {
      radius = 24;
      borderColor = PrimaryNewColor().focus;
    }

    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: borderColor),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  Widget? _renderPrefixIcon() {
    if (type == AppTextFieldType.phoneNumber) {
      return AppPrefixPhoneField(
        code: phoneCode,
        onSubmit: (country) {
          onTapPrefix?.call(country);
        },
      );
    }

    if (this.prefixIcon != null) {
      return Icon(
        prefixIcon,
        size: 24,
        color: IconColor.secondary,
      );
    }

    return null;
  }

  Widget _renderSuffixIcon() {
    IconData? icon;
    VoidCallback? onTap;

    switch (type) {
      case AppTextFieldType.password:
        if (state.isObscure.value) {
          icon = Iconsax.eye;
        } else {
          icon = Iconsax.eye_slash;
        }
        onTap = () {
          state.isObscure.value = !state.isObscure.value;
        };
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
        icon = (state.isFocus.value) ? Iconsax.close_circle5 : null;
        onTap = () {
          textEditingController.clear();
          state.focusNode.value.unfocus();
          onClear?.call();
        };
        break;
      default:
        icon = null;
        break;
    }

    return InkWell(
      onTap: onTap,
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
        EdgeInsets padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12);

        final isObscure = state.isObscure.value;

        if (isDisabled) {
          bgColor = BorderColor.secondary;
        }

        if (type == AppTextFieldType.search) {
          padding = const EdgeInsets.symmetric(horizontal: 12);
        }

        return TextFormField(
          focusNode: state.focusNode.value,
          canRequestFocus: canFocus,
          controller: textEditingController,
          onTap: onClick,
          readOnly: !isEditable,
          enabled: !isDisabled,
          keyboardType: state.inputType,
          maxLength: length,
          maxLines: state.maxLines,
          style: Theme.of(context).textTheme.bodyMedium,
          obscureText: (type == AppTextFieldType.password) ? isObscure : false,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: padding,
              hintText: placeholder,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.placeholder),
              counterStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.helper),
              filled: true,
              fillColor: bgColor,
              border: InputBorder.none,
              enabledBorder: getBorder(1),
              errorBorder: getBorder(1),
              focusedBorder: getFocusedBorder(),
              focusedErrorBorder: getBorder(3),
              suffixIcon: _renderSuffixIcon(),
              prefixIcon: _renderPrefixIcon(),
              errorStyle: TextStyle(fontSize: 0)),
          validator: (value) {
            if (type == AppTextFieldType.search) {
              return null;
            }

            final error = inputValidator(type, value, label ?? "", isRequired);
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
            onChanged?.call(value);
          },
        );
      },
    );
  }

  Widget _renderErrorText(BuildContext context) {
    return Obx(() {
      Color helperColor = TextColor.helper;

      if (state.isError.value) {
        helperColor = TextColor.error;
      }

      return (state.isError.value || helperText != null)
          ? Row(
              children: [
                Expanded(
                  child: Text(
                    state.errorText.value ?? helperText ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: helperColor),
                  ),
                ),
              ],
            )
          : const SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
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
        ],
        _renderTextField(context),
        _renderErrorText(context),
      ],
    );
  }
}
