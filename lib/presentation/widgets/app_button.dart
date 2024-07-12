part of 'widgets.dart';

enum AppButtonType { filled, outline, text, alternate, plain }

enum AppButtonShape { rounded, rect }

enum AppButtonSize { defaultSize, smallSize }

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.label,
    required this.onPress,
    required this.type,
    this.isLoading = false,
    this.shape = AppButtonShape.rounded,
    this.isFullWidth = true,
    this.size = AppButtonSize.defaultSize,
  })  : this.icon = null,
        this.svgIcon = null;

  AppButton.icon({
    super.key,
    required this.icon,
    required this.label,
    required this.onPress,
    required this.type,
    this.shape = AppButtonShape.rounded,
    this.isFullWidth = true,
    this.isLoading = false,
    this.size = AppButtonSize.defaultSize,
  }) : this.svgIcon = null;

  AppButton.svgIcon({
    super.key,
    required this.svgIcon,
    required this.label,
    required this.onPress,
    required this.type,
    this.shape = AppButtonShape.rounded,
    this.isFullWidth = true,
    this.isLoading = false,
    this.size = AppButtonSize.defaultSize,
  }) : this.icon = null;

  final String label;
  final AppButtonType type;
  final AppButtonShape shape;
  final bool isLoading;

  /// Wrap the button with Expanded widget if use fullwidth button inside row
  final bool isFullWidth;

  final Function()? onPress;
  final IconData? icon;
  final SvgPicture? svgIcon;

  /// Button size
  final AppButtonSize size;

  Widget _renderWithIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  Widget _renderWithSvgIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        svgIcon!,
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  Widget _renderText(BuildContext context) {
    return Text(label);
  }

  Widget _renderLoading() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: labelColor,
      ),
    );
  }

  Color bgColor = PrimaryNewColor().main;
  Color labelColor = PrimaryNewColor().content;
  Color pressedColor = PrimaryNewColor().pressed;
  Color? borderColor;
  ButtonShapeValue? shapeValue;

  RoundedRectangleBorder get shapeStyle => RoundedRectangleBorder(
        side: borderColor != null
            ? BorderSide(
                width: 1,
                color: borderColor!,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(shapeValue!.radius),
      );

  void _settingColor() {
    if (onPress == null) {
      switch (type) {
        case AppButtonType.filled:
          bgColor = BackgroundColor.disabled;
          labelColor = PrimaryNewColor().content;
          break;
        case AppButtonType.outline:
          bgColor = PrimaryNewColor().content;
          labelColor = TextColor.disabled;
          borderColor = BorderColor.disabled;
          break;
        case AppButtonType.text:
          bgColor = PrimaryNewColor().content;
          labelColor = TextColor.disabled;
          break;
        case AppButtonType.alternate:
          bgColor = BackgroundColor.secondary;
          labelColor = TextColor.disabled;
          break;
        case AppButtonType.plain:
          break;
      }
    } else {
      switch (type) {
        case AppButtonType.filled:
          bgColor = PrimaryNewColor().main;
          labelColor = PrimaryNewColor().content;
          pressedColor = PrimaryNewColor().pressed;
          break;
        case AppButtonType.outline:
          bgColor = PrimaryNewColor().content;
          labelColor = PrimaryNewColor().main;
          pressedColor = PrimaryNewColor().surface;
          borderColor = PrimaryNewColor().main;
          break;
        case AppButtonType.text:
          bgColor = PrimaryNewColor().content;
          labelColor = PrimaryNewColor().main;
          pressedColor = PrimaryNewColor().surface;
          break;
        case AppButtonType.alternate:
          bgColor = PrimaryNewColor().surface;
          labelColor = PrimaryNewColor().main;
          pressedColor = PrimaryNewColor().border;
          break;
        case AppButtonType.plain:
          bgColor = PlainColor().main;
          labelColor = PlainColor().content;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    shapeValue = Constants.buttonShapeValue[shape];

    _settingColor();

    // Adjust padding and text style based on the selected size here
    final double verticalPadding = size != AppButtonSize.smallSize
        ? 12
        : type != AppButtonType.text
            ? 8
            : 0;
    final double horizontalPadding = size != AppButtonSize.smallSize
        ? 24
        : type != AppButtonType.text
            ? 16
            : 0;
    final TextStyle? textStyle = size == AppButtonSize.smallSize ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.titleSmall;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: isFullWidth ? double.infinity : 0),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          minimumSize: Size.zero,
          shape: shapeStyle,
          backgroundColor: bgColor,
          foregroundColor: labelColor,
          disabledForegroundColor: labelColor,
          textStyle: textStyle,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Container(
          child: isLoading
              ? _renderLoading()
              : svgIcon != null
                  ? _renderWithSvgIcon(context)
                  : icon != null
                      ? _renderWithIcon(context)
                      : _renderText(context),
        ),
      ),
    );
  }
}
