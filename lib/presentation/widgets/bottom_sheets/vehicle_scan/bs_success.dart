part of '../../widgets.dart';

enum BSDescriptionType { success, warning, danger }

class SuccessBottomSheet extends StatelessWidget {
  final BSDescriptionType type;
  final String title;
  final String description;
  final Function()? onButtonPressed;

  const SuccessBottomSheet({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    this.onButtonPressed,
  }) : super(key: key);

  String get icon {
    switch (type) {
      case BSDescriptionType.success:
        return "assets/icons/ic_success_circle.svg";
      case BSDescriptionType.warning:
        return "assets/icons/ic_warning_circle.svg";
      case BSDescriptionType.danger:
        return "assets/icons/ic_alert_circle.svg";
    }
  }

  Widget _renderContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          icon,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.tertiary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16),
          // Main description content
          _renderContent(context),

          const SizedBox(height: 16),

          if (Platform.isIOS) const SizedBox(height: 24),
        ],
      ),
    );
  }
}
