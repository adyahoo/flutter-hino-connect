part of 'widgets.dart';

class AppFab extends StatelessWidget {
  const AppFab({super.key, required this.onAdd});

  final Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: PrimaryColor.main,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onAdd,
        splashColor: PrimaryColor.pressed,
        icon: Icon(
          Iconsax.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
