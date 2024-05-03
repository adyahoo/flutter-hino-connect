part of 'widgets.dart';

enum AppButtonType { filled, outline, alternate }

class AppButton extends StatelessWidget {
  const AppButton.filled({
    super.key,
    required this.label,
    required this.onPress,
  }) : this.type = AppButtonType.filled;

  const AppButton.outline({
    super.key,
    required this.label,
    required this.onPress,
  }) : this.type = AppButtonType.outline;

  final String label;
  final AppButtonType type;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor = PrimaryColor.main;
    Color labelColor;

    if (type == AppButtonType.filled) {
      bgColor = PrimaryColor.main;
      labelColor = PrimaryColor.content;
    } else {
      bgColor = PrimaryColor.content;
      labelColor = PrimaryColor.main;
    }

    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: labelColor),
        ),
      ),
    );
  }
}
