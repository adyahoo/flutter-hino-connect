import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPageController extends GetxController {
  var searchResults = <SearchResult>[].obs;

  final filteredResults = <SearchResult>[].obs;

  var currentInput = ''.obs;

  var isTextFieldEdited = false.obs;
  final Rx<TextEditingController> searchbarController = TextEditingController().obs;

  //map controller
  MapsController mapsController = Get.find<MapsController>();

  final searchBarState = AppTextFieldState();
  String? query;

  @override
  Future<void> onInit() async {
    super.onInit();
    searchBarState.focusNode.value.addListener(searchBarState.onFocusChange);
    searchResults.value = await StorageService().loadRecentSearches();
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

  void _getScreenArguments() {
    final arguments = Get.arguments ?? {};
    query = arguments['query'];

    if (query != null) {
      searchbarController.value.text = query!;
    }
  }

  void selectLocation(SearchResult result) {
    //create new array of search result with a new object before overwriting the searchResults
    final newSearchResults = [result, ...searchResults];

    // If the list already has 5 items, remove the last one.
    if (newSearchResults.length > 5) {
      newSearchResults.removeLast();
    }

    //update the searchResults
    searchResults.value = newSearchResults;

    inject<StorageService>().saveRecentSearches(searchResults);

    Get.back();
    Future.delayed(Duration(milliseconds: 500), () {
      mapsController.moveCamera(LatLng(result.lat, result.lng));
      mapsController.searchbarController.value.text = result.name;
    });
  }

  void removeRecentSearchSelected(SearchResult result) {
    final newSearchResults = searchResults.where((element) => element != result).toList();
    searchResults.value = newSearchResults;

    StorageService.instance().then((storage) {
      storage!.saveRecentSearches(searchResults);
    });
  }

  Future<void> search(String input) async {
    currentInput.value = input;
    String apiKey = Constants.MAP_API_KEY;

    // The URL of the Google Maps API Place Autocomplete
    final type = "gas_station|restaurant|car_dealer";
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input'
        '&key=$apiKey'
        '&types=$type'
        '&location=${mapsController.currentLocation.latitude}%2C${mapsController.currentLocation.longitude}'
        '&radius=5000';

    // Send a GET request to the API
    var response = await http.get(Uri.parse(url));

    // If the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(response.body);
      print('Details JSON');
      //print json response in json stringify format
      print(jsonEncode(jsonResponse));

      // Clear the current results
      filteredResults.clear();

      // For each item in the JSON response, create a new Result and add it to results
      for (var item in jsonResponse['predictions']) {
        // Get the place details
        var detailsResponse = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=${item['place_id']}&key=$apiKey'));

        if (detailsResponse.statusCode == 200) {
          var detailsJson = jsonDecode(detailsResponse.body);

          var location = detailsJson['result']['geometry']['location'];
          var vicinity = detailsJson['result']['formatted_address'];

          filteredResults.add(SearchResult(
            name: item['structured_formatting']['main_text'],
            vicinity: vicinity,
            lat: location['lat'],
            lng: location['lng'],
          ));
        } else {
          throw Exception('Failed to load place details');
        }
      }
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to load results');
    }
  }
}
