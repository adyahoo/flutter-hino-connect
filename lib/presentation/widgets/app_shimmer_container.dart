part of 'widgets.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      direction: ShimmerDirection.ltr,
      child: child,
    );
  }
}
