part of 'widgets.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.verticalSpace = 12});

  final double verticalSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: BorderColor.primary,
      margin: EdgeInsets.symmetric(vertical: verticalSpace),
    );
  }
}

enum AppDividerDirection { horizontal, vertical }

class AppStrippedDivider extends StatelessWidget {
  const AppStrippedDivider({super.key, this.direction = AppDividerDirection.horizontal});

  final AppDividerDirection direction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final boxHeight = constraints.constrainHeight();

        const dashWidth = 4.0;
        const dashHeight = 1.0;
        int dashCount = (boxWidth / (2 * dashWidth)).floor();

        if (direction == AppDividerDirection.vertical) {
          dashCount = (boxHeight / (2 * dashWidth)).floor();
        }

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: (direction == AppDividerDirection.horizontal) ? dashWidth : dashHeight,
              height: (direction == AppDividerDirection.horizontal) ? dashHeight : dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: BorderColor.primary),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: (direction == AppDividerDirection.horizontal) ? Axis.horizontal : Axis.vertical,
        );
      },
    );
  }
}
