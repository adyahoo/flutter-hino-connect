part of '../../widgets.dart';

class BsSos extends GetView<BsSosController> {
  const BsSos({super.key});

  Widget _renderHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "need_help".tr,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: TextColor.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          "contact_us".tr,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: TextColor.secondary),
        ),
      ],
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _renderContent(BuildContext context) {
    if (controller.isFetching.value) {
      return _renderLoading();
    }

    final data = controller.data.value;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400),
      child: SingleChildScrollView(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) => _renderCard(context, data[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }

  Widget _renderCard(BuildContext context, ContactModel item) {

    bool isPersonalContact = item.address == null;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: BorderColor.primary,
          width: 1,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !isPersonalContact ? SvgPicture.asset(
                  "assets/icons/ic_house.svg",
                  width: 20,
                  height: 20,
                ) : SizedBox.shrink(),
                SizedBox(width: isPersonalContact ? 0 : 4),
                Text(
                  item.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: TextColor.secondary),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "(${item.code}) ${item.phone}",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: TextColor.secondary),
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            !isPersonalContact ? Text(
              item.address ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.secondary),
              maxLines: 1,
            ) : SizedBox.shrink(),
            !isPersonalContact ? AppDivider(): AppStrippedDivider(verticalSpace: 12),
            AppButton.icon(
              icon: Icons.call,
              label: "call_us".tr,
              onPress: navigateWA,
              type: AppButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }

  void navigateWA() {}

  @override
  Widget build(BuildContext context) {
    Get.put<BsSosController>(BsSosController(useCase: inject()));

    return Container(
      padding: const EdgeInsets.only(right: 16, bottom: 24, left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BsNotch(),
          _renderHeader(context),
          const SizedBox(height: 24),
          Obx(() => _renderContent(context)),
        ],
      ),
    );
  }
}
