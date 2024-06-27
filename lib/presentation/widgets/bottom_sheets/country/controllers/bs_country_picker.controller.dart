import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/domain/core/usecases/country_use_case.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class BsCountryPickerController extends GetxController {
  BsCountryPickerController({required this.useCase});

  final CountryUseCase useCase;

  final items = <CountryModel>[].obs;
  final filteredItems = <CountryModel>[].obs;
  final selectedId = ''.obs;
  final isFetching = false.obs;

  TextEditingController searchController = TextEditingController();
  final searchState = AppTextFieldState();

  @override
  void onInit() {
    getCountries();
    super.onInit();
  }

  Future<void> search(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (query.isEmpty) {
      filteredItems.value = items;
    } else {
      final results = items
          .where(
            (element) => element.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
      filteredItems.value = results;
    }
  }

  void setSelectedOption(String id) {
    selectedId.value = id;
  }

  CountryModel getSelectedItem() {
    final selected = items.firstWhere((element) => element.phoneCode == selectedId.value);
    setSelectedOption(selected.phoneCode);

    return selected;
  }

  void getCountries() async {
    items.value = await useCase.getCountries();
    filteredItems.value = await useCase.getCountries();
  }
}
