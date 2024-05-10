part of '../widgets.dart';

class BsNotch extends StatelessWidget {
  const BsNotch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48,
        height: 4,
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: BorderColor.primary,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
