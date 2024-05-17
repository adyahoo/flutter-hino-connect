part of 'widgets.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final bool editable;

  const AppSearchBar({Key? key, required this.onSearch, this.editable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: AppTextField.search(
          textEditingController: TextEditingController(),
          type: AppTextFieldType.search,
          state: AppTextFieldState(),
          isEditable: editable,
          onChanged: (value) {
            print(value);
            onSearch(value);
          },
          onClick: () {
            print('Search');
            Get.toNamed(Routes.SEARCH);
          },
        ),
      ),
    );
  }
}
