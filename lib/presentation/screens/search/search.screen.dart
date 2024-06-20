import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'controllers/search.controller.dart';

part 'widgets/search_app_bar.dart';

class SearchScreen extends GetView<SearchPageController> {
  const SearchScreen({Key? key}) : super(key: key);

  Widget emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.location_cross5,
                size: 32, color: IconColor.secondary),
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'location_not_found_title'.tr,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'location_not_found_subtitle'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _renderLocationInfo(
      BuildContext context, SearchResult location, IconData icon) {
    return GestureDetector(
      onTap: () {
        print('Location info tapped');
        //go back and move to the selected location
        controller.selectLocation(location);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: IconColor.secondary),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(location.vicinity,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderRecentSearchList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "recent_search".tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Obx(
              () {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 0),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final result = controller.searchResults[index];

                    return GestureDetector(
                      onTap: () {
                        controller.selectLocation(result);
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: InfoColor.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.access_time,
                              color: InfoColor.main,
                              size: 20,
                            ), // Time icon
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              result.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Iconsax.close_circle,
                              size: 20,
                            ),
                            onPressed: () {
                              controller.removeRecentSearchSelected(result);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget onTypingState(BuildContext context) {
    return Obx(() {
      // if (controller.filteredResults.isEmpty) {
      //   return emptyState(context);
      // }

      return ListView.separated(
        separatorBuilder: (context, index) => AppDivider(),
        itemCount: controller.filteredResults.length,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemBuilder: (context, index) {
          final result = controller.filteredResults[index];
          return _renderLocationInfo(
              context, result, Icons.location_on_outlined);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        controller: controller,
        onTyping: () {
          // onTypingState(context);
        },
      ),
      body: Obx(
        () {
          // if (controller.currentInput.value.isNotEmpty || controller.searchbarController.value.text.isNotEmpty) {
          //   controller.search(controller.searchbarController.value.text);
          //
          //   return onTypingState(context);
          // } else {
          //   if (controller.searchResults.isEmpty) {
          //     return emptyState(context);
          //   } else {
          //     return _renderRecentSearchList(context);
          //   }
          // }

          if (controller.filteredResults.isNotEmpty) {
            return onTypingState(context);
          } else {
            // if (controller.searchResults.isEmpty || (controller.filteredResults.isEmpty && controller.searchbarController.value.text.isNotEmpty)) {
            //   print('Empty state');
            //   return emptyState(context);
            // }
            // if(controller.searchbarController.value.text.isEmpty && controller.searchResults.length == 0) {
            //   // return emptyState(context);
            // }

            if (controller.filteredResults.isNotEmpty) {
              return onTypingState(context);
            }

            if (controller.searchbarController.value.text.isEmpty &&
                controller.searchResults.isEmpty) {
              return Container();
            }

            if (controller.searchbarController.value.text.isNotEmpty &&
                controller.filteredResults.isEmpty) {
              return emptyState(context);
            }

            return _renderRecentSearchList(context);
          }
        },
      ),
    );
  }
}
