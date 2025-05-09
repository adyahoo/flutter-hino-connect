part of '../home.screen.dart';

class HomeAppBar extends GetView<HomeController> {
  const HomeAppBar({super.key});

  Widget _renderLoadinName() {
    return ShimmerContainer(
      child: Container(
        width: 200,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/home_header_illust.png",
          height: 220,
          width: MediaQuery.of(context).size.width,
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
                    height: 23,
                  ),
                  const HomeAccountChip(),
                ],
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.isFetchingUser.value
                    ? _renderLoadinName()
                    : Text(
                        "welcome".tr + ", ${controller.user.value?.name}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 4),
              Text(
                "welcome_subtitle".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
