part of '../../widgets.dart';

class BsSinglePicker extends StatelessWidget {
  const BsSinglePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            "title",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.secondary),
          ),

        ],
      ),
    );
  }
}
