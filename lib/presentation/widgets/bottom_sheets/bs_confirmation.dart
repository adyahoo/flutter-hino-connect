part of '../widgets.dart';

enum BsConfirmationType { success, warning, danger }

class BsConfirmation extends StatelessWidget {
  const BsConfirmation({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.positiveButtonOnClick,
    this.negativeButtonOnClick,
    this.positiveTitle,
    this.negativeTitle,
    this.isMultiAction = true,
  }) : super(key: key);

  final BsConfirmationType type;
  final String title;
  final String description;
  final VoidCallback positiveButtonOnClick;
  final VoidCallback? negativeButtonOnClick;
  final String? positiveTitle;

  /// will have "cancel" as default value
  final String? negativeTitle;

  /// handle when the bs show multi action button or single full-width button (default: true)
  final bool isMultiAction;

  String get icon {
    switch (type) {
      case BsConfirmationType.success:
        return "assets/icons/ic_success_circle.svg";
      case BsConfirmationType.warning:
        return "assets/icons/ic_warning_circle.svg";
      case BsConfirmationType.danger:
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

  Widget _renderActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (isMultiAction)
            ? Expanded(
                flex: 1,
                child: AppButton(
                  label: negativeTitle ?? 'cancel'.tr,
                  onPress: () {
                    Get.back();

                    if (negativeButtonOnClick != null) {
                      negativeButtonOnClick!();
                    }
                  },
                  type: AppButtonType.outline,
                ),
              )
            : const SizedBox(),
        (isMultiAction) ? const SizedBox(width: 16) : const SizedBox(),
        Expanded(
          flex: 1,
          child: AppButton(
            label: positiveTitle ?? 'confirm'.tr,
            onPress: positiveButtonOnClick,
            type: AppButtonType.filled,
          ),
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
          // Drag handle
          const BsNotch(),
    
          // Main description content
          _renderContent(context),
    
          const SizedBox(height: 16),
    
          // Footer with two buttons
          _renderActions(context),

          if (Platform.isIOS) const SizedBox(height: 24),
        ],
      ),
    );
  }
}