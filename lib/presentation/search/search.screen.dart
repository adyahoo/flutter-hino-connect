import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
          Icon(Iconsax.location_cross, size: 56, color: Color(0xffF5F5F5)),
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

  Widget _renderLocationInfo(
      BuildContext context, String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: IconColor.secondary),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  //!!MODIFY THIS WIDGET LATER
  Widget onTypingState(BuildContext context, String input) {
    // Generate a list of widgets based on the input
    List<Widget> widgets = input.split(' ').map((word) {
      return _renderLocationInfo(
          context, word, 'Value for $word', Icons.location_on_outlined);
    }).toList();

    return ListView(children: widgets);
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
              onSearch: (input) {
                // Call the search function in your controller
                controller.search(input);
                onTypingState(context, input);
              },
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    AppChip(
                      label: 'Gas Station',
                      icon: Iconsax.gas_station4,
                      id: 'filter_gas_station',
                      onSelected: (isSelected) {},
                    ),
                    SizedBox(width: 8),
                    AppChip(
                      label: 'Dealers',
                      icon: Iconsax.truck,
                      id: 'filter_dealers',
                      onSelected: (isSelected) {},
                    ),
                    SizedBox(width: 8),
                    AppChip(
                      label: 'Restaurant',
                      icon: Icons.coffee,
                      id: 'filter_restaurant',
                      onSelected: (isSelected) {},
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
          child: Obx(() {
            if (controller.currentInput.isNotEmpty) {
              return onTypingState(context, controller.currentInput.value);
            } else {
              if(controller.results.isEmpty){
                return emptyState(context);
              }
              else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Search',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.results.length,
                      separatorBuilder: (context, index) => SizedBox(height: 0),
                      itemBuilder: (context, index) {
                        final result = controller.results[index];
                        return Row(
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
                                result.title,
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
                                  //TODO: Remove recent search
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
              }
            }
          }),
        ),
      ),
    );
  }
}
