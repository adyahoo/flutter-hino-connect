part of '../search.screen.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key, required this.controller, required this.onTyping});

  final SearchPageController controller;
  final Function() onTyping;
  final double height = 100.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      titleSpacing: 0.0,
      backgroundColor: Colors.white,
      shape: Border(bottom: BorderSide(width: 1, color: BorderColor.primary)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: IconColor.primary),
        onPressed: () => Get.back(),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8),
        child: AppSearchBar(
          hintText: "searchbar_placeholder".tr,
          controller: controller.searchbarController.value,
          state: controller.searchBarState,
          onClear: controller.onClearInput,
          onChanged: (input) {
            // Call the search function in your controller
            controller.search(input);
            onTyping();
          },
        ),
      ),
      bottom: BottomSearchBar(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class BottomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppFilter(
          chips: Constants.mapScreenFilterItems,
          onClick: (item) {
            Get.back(result: item);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
