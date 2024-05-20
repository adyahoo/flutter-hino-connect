part of 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.bottom,
  });

  final String title;
  final PreferredSizeWidget? bottom;

  final height = 112.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      titleSpacing: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: IconColor.primary),
        onPressed: () => Get.back(),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor: Colors.white,
      centerTitle: false,
      bottom: bottom ?? null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class AppbarBottomPicker extends StatelessWidget implements PreferredSizeWidget {
  const AppbarBottomPicker({
    super.key,
    required this.onTap,
    required this.textEditingController,
  });

  final VoidCallback onTap;
  final TextEditingController textEditingController;

  final height = 56.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, bottom: 12, left: 16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: BorderColor.primary))),
      child: AppTextField.picker(
        onClick: onTap,
        placeholder: 'filter_by_date'.tr,
        textEditingController: textEditingController,
        state: AppTextFieldState(),
        type: AppTextFieldType.single_picker,
        shape: AppTextFieldShape.rounded,
        prefixIcon: Iconsax.calendar5,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
