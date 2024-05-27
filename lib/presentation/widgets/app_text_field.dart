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
        this.withIcon = false;

  AppTextField.icon({
    super.key,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    this.label,
    this.helperText,
    this.onChanged,
    this.prefixIcon,
    this.shape = AppTextFieldShape.rect,
    this.isRequired = true,
    this.isEditable = true,
    this.isDisabled = false,
    this.length = null,
  })  : this.withIcon = true,
        this.canFocus = true,
        this.onClick = null;

  AppTextField.picker({
    super.key,
    required this.placeholder,
    required this.textEditingController,
    required this.state,
    required this.type,
    required this.onClick,
    this.onChanged,
    this.label,
    this.helperText,
    this.prefixIcon,
    this.shape = AppTextFieldShape.rect,
    this.isRequired = true,
    this.isDisabled = false,
  })  : this.withIcon = true,
        this.length = null,
        this.canFocus = true,
        this.isEditable = false;

  AppTextField.search({
    super.key,
    required this.textEditingController,
    required this.onClick,
    required this.state,
    required this.onChanged,
    this.label,
    this.helperText,
    this.prefixIcon,
    this.isDisabled = false,
    this.isEditable = true,
    this.shape = AppTextFieldShape.rounded,
    this.placeholder = 'Search',
    this.canFocus = true,
  })  : this.withIcon = true,
        this.type = AppTextFieldType.search,
        this.isRequired = false,
        this.length = null;

  final String placeholder;
  final TextEditingController textEditingController;
  final AppTextFieldState state;
  final AppTextFieldType type;
  final AppTextFieldShape shape;
  final bool isRequired;
  final bool isEditable;
  final bool isDisabled;
  final bool withIcon;
  final bool canFocus;
  final String? label;
  final int? length;
  final IconData? prefixIcon;
  final String? helperText;
  final VoidCallback? onClick;
  final ValueChanged<String>? onChanged;

  OutlineInputBorder getBorder(double width, Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(shape == AppTextFieldShape.rect ? 8 : 24),
    );
  }

  Widget _renderPrefixIcon() {
    return Icon(
      prefixIcon,
      size: 24,
      color: IconColor.secondary,
    );
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
        icon = Iconsax.close_circle5;
        onTap = () {
          textEditingController.clear();
          state.focusNode.value.unfocus();
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
        Color helperColor = TextColor.helper;
        Color borderColor = BorderColor.secondary;
        double borderWidth = 1;

        final isObscure = state.isObscure.value;
        final suffixIcon = withIcon ? _renderSuffixIcon() : null;
        final prefixIcon = this.prefixIcon != null ? _renderPrefixIcon() : null;

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
          state.copyWith(
            maxLines: 4,
            inputType: TextInputType.multiline,
          );
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
              keyboardType: state.inputType,
              maxLength: length,
              maxLines: state.maxLines,
              obscureText: (type == AppTextFieldType.password) ? isObscure : false,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  hintText: placeholder,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.placeholder),
                  counterStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.helper),
                  filled: true,
                  fillColor: bgColor,
                  border: InputBorder.none,
                  focusedBorder: getBorder(3, borderColor),
                  enabledBorder: getBorder(borderWidth, borderColor),
                  errorBorder: getBorder(borderWidth, borderColor),
                  focusedErrorBorder: getBorder(3, borderColor),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  errorStyle: TextStyle(fontSize: 0)),
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) {
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
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Widget _renderSearchTextField(BuildContext context) {
    final suffixIcon = withIcon ? _renderSuffixIcon() : null;
    final prefixIcon = this.prefixIcon != null ? _renderPrefixIcon() : null;
    Color bgColor = Colors.white;

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: state.focusNode.value,
            controller: textEditingController,
            readOnly: !isEditable,
            canRequestFocus: canFocus,
            onTap: () {
              if (onClick != null) onClick!();
            },
            onChanged: (text) {
              onChanged?.call(text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: bgColor,
              filled: true,
              focusedBorder: getBorder(3, PrimaryColor.focus),
              hintText: placeholder,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TextColor.placeholder,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              enabledBorder: getBorder(1, BorderColor.secondary),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              prefixIcon: prefixIcon,
              suffixIcon: state.isFocus.value ? suffixIcon : null,
            ),
          ),
        ],
      );
    });
  }

  Widget _renderPhoneNumberField(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              BsSinglePicker(
                type: BsSinglePickerType.withSearch,
                options: Constants.countryCodes,
                title: 'Kode Negara',
                selectedId: 1,
                // Set default selected id here
                onSubmit: (PickerModel value) {
                  // Handle selected country code
                  print('Selected: ${value.title}');
                  // Update the text field controller or state with the selected country code
                },
              ),
              isScrollControlled: true,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 13),
            decoration: BoxDecoration(
              border: Border.all(color: BorderColor.secondary),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: BorderColor.secondary,
            ),
            child: Row(
              children: [
                Text(
                  '+62', // Initial country code
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 4),
                Icon(
                  Iconsax.arrow_down_1,
                  size: 12,
                  color: IconColor.primary,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            focusNode: state.focusNode.value,
            controller: textEditingController,
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              hintText: placeholder,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.placeholder),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                borderSide: BorderSide(color: BorderColor.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                borderSide: BorderSide(color: BorderColor.primary, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                borderSide: BorderSide(color: BorderColor.secondary, width: 1),
              ),
            ),
            validator: (value) {
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
            },
          ),
        ),
      ],
    );
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
        //   (type == AppTextFieldType.search)
        //       ? _renderSearchTextField(context)
        //       : _renderTextField(context),
        // ],
        (type == AppTextFieldType.search)
            ? _renderSearchTextField(context)
            : (type == AppTextFieldType.phoneNumber)
                ? _renderPhoneNumberField(context)
                : _renderTextField(context),
      ],
    );
  }
}
