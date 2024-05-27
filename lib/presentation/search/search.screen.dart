import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'controllers/search.controller.dart';

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
            child: Icon(Iconsax.location_cross5, size: 32, color: IconColor.secondary),
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Lokasi tidak ditemukan',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Coba menggunakan kata kunci lain untuk menemukan lokasi.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _renderLocationInfo(BuildContext context, SearchResult location, IconData icon) {
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
                  Text(location.vicinity, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget onTypingState(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        separatorBuilder: (context, index) => AppDivider(),
        itemCount: controller.filteredResults.length,
        itemBuilder: (context, index) {
          final result = controller.filteredResults[index];
          return _renderLocationInfo(context, result, Icons.location_on_outlined);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: IconColor.primary),
            onPressed: () => Get.back(),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: AppSearchBar(
              hintText: 'Cari tempat..',
              controller: controller.searchbarController.value,
              state: controller.searchBarState,
              onChanged: (input) {
                // Call the search function in your controller
                controller.search(input);
                // onTypingState(context, input);
                onTypingState(context);
              },
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppFilter(
                  chips: [
                    AppChip(
                      label: 'Gas Station',
                      icon: Iconsax.gas_station4,
                      id: 'filter_gas_station',
                    ),
                    AppChip(
                      label: 'Dealers',
                      icon: Iconsax.truck,
                      id: 'filter_dealers',
                    ),
                    AppChip(
                      label: 'Restaurant',
                      icon: Icons.coffee,
                      id: 'filter_restaurant',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Expanded(
          child: Obx(
            () {
              if (controller.currentInput.isNotEmpty) {
                // return onTypingState(context, controller.currentInput.value);
                return onTypingState(context);
              } else {
                print('masuk else statement');
                if (controller.searchResults.isEmpty) {
                  return emptyState(context);
                } else {
                  print('Recent Search');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Search',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 4),
                      Expanded(
                        child: Expanded(
                          child: Obx(() {
                            return ListView.separated(
                              itemCount: controller.searchResults.length,
                              separatorBuilder: (context, index) => SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final result = controller.searchResults[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectLocation(result);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.0),
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
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          result.name,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.zero,
                                        child: IconButton(
                                          icon: Icon(
                                            Iconsax.close_circle,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            controller.removeRecentSearchSelected(result);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
