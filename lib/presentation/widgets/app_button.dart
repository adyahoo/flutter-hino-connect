part of 'widgets.dart';

enum AppButtonType { filled, outline, text, alternate }

enum AppButtonShape { rounded, rect }

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.label,
    required this.onPress,
    required this.type,
    this.icon,
    this.shape = AppButtonShape.rounded,
  });

  AppButton.icon({
    super.key,
    required this.icon,
    required this.label,
    required this.onPress,
    required this.type,
    this.shape = AppButtonShape.rounded,
  });

  final String label;
  final AppButtonType type;
  final AppButtonShape shape;
  final Function()? onPress;
  final IconData? icon;

  Widget _renderWithIcon(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: labelColor,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: labelColor),
        ),
      ],
    );
  }

  Widget _renderText(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: labelColor),
    );
  }

  Color bgColor = PrimaryColor.main;
  Color labelColor = PrimaryColor.content;
  Color pressedColor = PrimaryColor.pressed;
  Color? borderColor;
  ButtonShapeValue? shapeValue;

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

    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(shapeValue!.radius),
        border: borderColor != null
            ? Border.all(
                width: 1,
                color: borderColor!,
              )
            : null,
      ),
      child: InkWell(
        onTap: onPress,
        splashColor: pressedColor,
        borderRadius: BorderRadius.circular(shapeValue!.radius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: icon != null ? _renderWithIcon(context) : _renderText(context),
        ),
      ),
    );
  }
}
