part of '../home.screen.dart';

class HomeAccountChip extends GetView<HomeController> {
  const HomeAccountChip({super.key});

  Widget _renderLoadingAvatar() {
    return ShimmerContainer(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PROFILE);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => SizedBox(
                width: 24,
                height: 24,
                child: controller.isFetchingUser.value
                    ? _renderLoadingAvatar()
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          controller.user.value?.profilePic ?? "",
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "account".tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
            )
          ],
        ),
      ),
    );
  }
}
