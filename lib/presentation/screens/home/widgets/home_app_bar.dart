part of '../home.screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/home_header_illust.png",
          height: 220,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/logo_white.svg",
                    height: 18,
                  ),
                  const HomeAccountChip(),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Selamat data, mamank skkrrttt",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                "Scan mobil untuk mendapatkan tugas dan rute perjalanan Anda",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
