part of 'widgets.dart';

enum AppButtonType { filled, outline, text, alternate }

enum AppButtonShape { rounded, rect }

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.label,
    required this.onPress,
    required this.type,
    this.isLoading = false,
    this.shape = AppButtonShape.rounded,
    this.isFullWidth = true,
  }) : this.icon = null;

  AppButton.icon({
    super.key,
    required this.icon,
    required this.label,
    required this.onPress,
    required this.type,
    this.shape = AppButtonShape.rounded,
    this.isFullWidth = true,
    this.isLoading = false,
  });

  final String label;
  final AppButtonType type;
  final AppButtonShape shape;
  final bool isLoading;
  final bool isFullWidth;
  final Function()? onPress;
  final IconData? icon;

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

  Color bgColor = PrimaryColor.main;
  Color labelColor = PrimaryColor.content;
  Color pressedColor = PrimaryColor.pressed;
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

  @override
  Widget build(BuildContext context) {
    shapeValue = Constants.buttonShapeValue[shape];

    switch (type) {
      case AppButtonType.filled:
        bgColor = PrimaryColor.main;
        labelColor = PrimaryColor.content;
        pressedColor = PrimaryColor.pressed;
        break;
      case AppButtonType.outline:
        bgColor = PrimaryColor.content;
        labelColor = PrimaryColor.main;
        pressedColor = PrimaryColor.surface;
        borderColor = PrimaryColor.main;
        break;
      case AppButtonType.text:
        bgColor = PrimaryColor.content;
        labelColor = PrimaryColor.main;
        pressedColor = PrimaryColor.surface;
        break;
      case AppButtonType.alternate:
        bgColor = PrimaryColor.surface;
        labelColor = PrimaryColor.main;
        pressedColor = PrimaryColor.border;
        break;
    }

    return Expanded(
      flex: isFullWidth ? 1 : 0,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: isFullWidth ? 12 : 0),
          minimumSize: Size.zero,
          shape: shapeStyle,
          backgroundColor: bgColor,
          foregroundColor: labelColor,
          textStyle: Theme.of(context).textTheme.titleSmall,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap
        ),
        child: Container(
          child: isLoading
              ? _renderLoading()
              : icon != null
                  ? _renderWithIcon(context)
                  : _renderText(context),
        ),
      ),
    );
  }
}
