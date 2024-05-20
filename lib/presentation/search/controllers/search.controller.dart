import 'package:get/get.dart';
import 'package:hino_driver_app/data/locals/StorageService.dart';
import 'package:hino_driver_app/domain/core/entities/search_result_model.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';
import 'package:hino_driver_app/presentation/widgets/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// class SearchResult {
//   final String name;
//   final String visibility;
//   final double lat;
//   final double lng;

//   SearchResult({
//     required this.name,
//     required this.visibility,
//     required this.lat,
//     required this.lng,
//   });
// }

class SearchPageController extends GetxController {
  var searchResults = <SearchResult>[].obs;

  final filteredResults = <SearchResult>[].obs;

  var currentInput = ''.obs;

  var isTextFieldEdited = false.obs;

  //map controller
  MapsController mapsController = Get.find<MapsController>();

  final searchBarState = AppTextFieldState();
  

  @override
  Future<void> onInit() async {
    super.onInit();
    searchBarState.focusNode.value.addListener(searchBarState.onFocusChange);

    // Populate results with some dummy data
    // searchResults.addAll([
    //   SearchResult(
    //       name: 'Pom Bensin Hayam Wuruk',
    //       vicinity: 'Subtitle 1',
    //       lat: -6.1751,
    //       lng: 106.8650),
    //   SearchResult(
    //       name: 'Resto ayam kencana',
    //       vicinity: 'Subtitle 2',
    //       lat: -6.1751,
    //       lng: 106.8650),
    //   SearchResult(
    //       name: 'POM Bensin sanur',
    //       vicinity: 'Subtitle 3',
    //       lat: -6.1751,
    //       lng: 106.8650),
    //   SearchResult(
    //       name: 'POM Bensin Kuta',
    //       vicinity: 'Subtitle 4',
    //       lat: -6.1751,
    //       lng: 106.8650),
    // ]);

    
  searchResults.value = await StorageService().loadRecentSearches();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchBarState.focusNode.value.removeListener(searchBarState.onFocusChange);
  }

  

  // bool onChangeListener(String value) {
  //   if (value.isEmpty) {
  //     isTextFieldEdited.value = false;
  //     return false;
  //   } else {
  //     isTextFieldEdited.value = true;
  //     return true;
  //   }
  // }

  void selectLocation(SearchResult result) {
    print('Selected Location: ${result.name}');

    //create new array of search result with a new object before overwriting the searchResults
    final newSearchResults = [result, ...searchResults];

    //update the searchResults
    searchResults.value = newSearchResults;

    inject<StorageService>().saveRecentSearches(searchResults);

    Get.back();
    Future.delayed(Duration(milliseconds: 500), () {
      mapsController.moveCamera(result.lat, result.lng);
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
    // currentInput.value = input;

    // The URL of the Google Maps API Place Autocomplete
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

    // Send a GET request to the API
    var response = await http.get(Uri.parse(url));

    // If the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(response.body);
      print('Details JSON');

      // Clear the current results
      filteredResults.clear();

      // For each item in the JSON response, create a new Result and add it to results
      for (var item in jsonResponse['predictions']) {
        // Get the place details
        var detailsResponse = await http.get(Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${item['place_id']}&key=$apiKey'));

        if (detailsResponse.statusCode == 200) {
          var detailsJson = jsonDecode(detailsResponse.body);

          var location = detailsJson['result']['geometry']['location'];
          var vicinity = detailsJson['result']['formatted_address'];

          filteredResults.add(SearchResult(
            name: item['description'],
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
