part of 'widgets.dart';

enum AppTipsType { basic, outline, filled }

class AppTips extends StatelessWidget {
  AppTips({
    super.key,
    required this.content,
    required this.variant,
    this.title,
    this.onDismiss,
  });

  final String content;
  final WidgetVariant variant;
  final String? title;
  final Function()? onDismiss;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (variant) {
      case WidgetVariant.info:
        bgColor = InfoColor.surface;
        iconColor = InfoColor.main;
        icon = Iconsax.info_circle;
        break;
      case WidgetVariant.danger:
        bgColor = ErrorColor.surface;
        iconColor = ErrorColor.main;
        icon = Iconsax.info_circle;
        break;
      case WidgetVariant.warning:
        bgColor = WarningColor.surface;
        iconColor = WarningColor.main;
        icon = Iconsax.info_circle;
        break;
      case WidgetVariant.success:
        bgColor = SuccesColor.surface;
        iconColor = SuccesColor.main;
        icon = Iconsax.info_circle;
        break;
      case WidgetVariant.primary:
        bgColor = PrimaryColor.surface;
        iconColor = PrimaryColor.main;
        icon = Iconsax.info_circle;
        break;
      default:
        bgColor = SuccesColor.surface;
        iconColor = SuccesColor.main;
        icon = Iconsax.info_circle;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bgColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (title != null)
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          title!,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      )
                    : const SizedBox(),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          (onDismiss != null)
              ? Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: onDismiss,
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: IconColor.secondary,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
