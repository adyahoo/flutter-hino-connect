import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/model.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/profile/controllers/profile.controller.dart';

class BsSinglePickerController extends GetxController {
  var selectedOption = 0.obs;
  final isFetching = false.obs;

  var items = <PickerModel>[].obs;
  var filteredItems = <PickerModel>[].obs;
  TextEditingController searchController = TextEditingController();

  BsSinglePickerController(this.items,) {
    filteredItems.value = items;
    print('filteredItems: $filteredItems');
  }

  Future<void> search(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    print('query: $query');
    if (query.isEmpty) {
      filteredItems.value = items;
    } else {
      final results = items
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredItems.value = results;
    }

    print('filteredItems: $filteredItems');
  }

  void setSelectedOption(int id) {
    selectedOption.value = id;
  }

  @override
  void onInit() {
    super.onInit();
    print('items: $items');
    searchController = TextEditingController();
    searchController.addListener(() {
      search(searchController.text);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
