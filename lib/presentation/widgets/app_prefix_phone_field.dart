part of 'widgets.dart';

class AppPrefixPhoneField extends StatelessWidget {
  const AppPrefixPhoneField({
    super.key,
    required this.code,
    required this.onSubmit,
  });

  final String code;
  final Function(CountryModel country) onSubmit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          BsCountryPicker(
            selectedId: code,
            onSubmit: onSubmit,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: BorderColor.secondary),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: BackgroundColor.secondary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "+$code",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 4),
            const Icon(
              Iconsax.arrow_down_1,
              size: 12,
              color: IconColor.primary,
            ),
          ],
        ),
      ),
    );
  }
}
