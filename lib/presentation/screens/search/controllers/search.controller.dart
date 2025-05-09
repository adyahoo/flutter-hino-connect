import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/entities/place_model.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/domain/core/usecases/recent_search_use_case.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';

class SearchPageController extends GetxController {
  SearchPageController({required this.useCase});

  final RecentSearchUseCase useCase;

  final searchResults = <SearchResult>[].obs;
  final filteredResults = <SearchResult>[].obs;
  final currentInput = ''.obs;
  final isTextFieldEdited = false.obs;
  final Rx<TextEditingController> searchbarController = TextEditingController().obs;

  final isBusySearch = false.obs;

  //map controller
  MapsController mapsController = Get.find<MapsController>();

  final searchBarState = AppTextFieldState();
  String? query;

  @override
  Future<void> onInit() async {
    super.onInit();
    searchBarState.focusNode.value.addListener(searchBarState.onFocusChange);
    _getRecentSearch();
  }

  @override
  void onReady() {
    super.onReady();
    _getScreenArguments();
  }

  @override
  void onClose() {
    super.onClose();
    searchBarState.focusNode.value.removeListener(searchBarState.onFocusChange);
  }

  void _getRecentSearch() async {
    await useCase.getRecentSearch().then((value) {
      searchResults.value = value.reversed.toList();
    });
  }

  void _getInitialSearchedPlaces() async {
    if (searchbarController.value.text.isNotEmpty) {
      search(searchbarController.value.text);
    }
  }

  void onClearInput() {
    filteredResults.value = [];
    mapsController.searchbarController.value.clear();

    _getRecentSearch();
  }

  void _getScreenArguments() {
    final arguments = Get.arguments ?? {};
    query = arguments['query'];

    if (query != null) {
      searchbarController.value.text = query!;
      _getInitialSearchedPlaces();
    }
  }

  Future<void> selectLocation(SearchResult result) async {
    final newSearchResults = [result, ...searchResults];

    // If the list already has 5 items, remove the last one.
    if (newSearchResults.length > 5) {
      newSearchResults.removeLast();
    }

    //update the searchResults
    searchResults.value = newSearchResults;
    await useCase.addRecentSearch(result);

    print('');
    print('Search Results: ${result.type}');

    Get.back();
    Future.delayed(Duration(milliseconds: 500), () async {
      final placeDetails = await getPlaceDetails(result);
      mapsController.initSpecificMarker(placeDetails);
      mapsController.searchbarController.value.text = result.name;
    });
  }

  Future<void> removeRecentSearchSelected(SearchResult result) async {
    await useCase.removeRecentSearch(result);

    await useCase.getRecentSearch().then((value) {
      searchResults.value = value.reversed.toList();
    });
  }

  Future<void> search(String input) async {
    currentInput.value = input;

    final value = await useCase.searchPlaces(input, mapsController.currentLocation.latitude, mapsController.currentLocation.longitude);
    filteredResults.value = value;
  }

  Future<PlaceModel> getPlaceDetails(SearchResult result) async {
    PlaceModel place = PlaceModel(
      name: result.name,
      address: result.vicinity,
      phone: 'N/A',
      latitude: result.lat.toString(),
      longitude: result.lng.toString(),
      type: result.type,
    );

    return place;
  }
}
