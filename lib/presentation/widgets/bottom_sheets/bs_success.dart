part of '../widgets.dart';

class SuccessBottomSheet extends StatelessWidget {
  final FeedbackModel feedback;
  final Function()? onButtonPressed;

  const SuccessBottomSheet({
    Key? key,
    required this.feedback,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Drag handle
              BsNotch(),
              SizedBox(height: 16),
              Text(
                feedback.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TextColor.secondary),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Dibuat oleh ${feedback.createdBy}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: TextColor.secondary),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 2.0, // Adjust the size of the circle here
                    backgroundColor: BorderColor
                        .primary, // Adjust the color of the circle here
                  ),
                  SizedBox(width: 8),
                  Text(
                    feedback.createdAt,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: TextColor.secondary),
                  ),
                ],
              ),
              SizedBox(height: 12),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: BorderColor.primary,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
              ),
              SizedBox(height: 12),
              Text(
                feedback.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: TextColor.secondary),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: AppButton(
                  label: 'Close',
                  type: AppButtonType.filled,
                  onPress: () {
                    onButtonPressed!();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
