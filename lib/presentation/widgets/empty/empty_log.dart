part of '../widgets.dart';

class EmptyLog extends StatelessWidget {
  const EmptyLog({super.key, required this.icon, required this.title, required this.description});

  /// this icon using svg from assets
  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BackgroundColor.secondary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                "assets/icons/$icon",
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
