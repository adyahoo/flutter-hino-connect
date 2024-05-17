import 'package:get/get.dart';
import 'package:hino_driver_app/infrastructure/constants.dart';
import 'package:hino_driver_app/presentation/screens/maps/controllers/maps.controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchResult {
  final String name;
  final String visibility;
  final double lat;
  final double lng;

  SearchResult({
    required this.name,
    required this.visibility,
    required this.lat,
    required this.lng,
  });
}

class SearchPageController extends GetxController {
  var searchResults = <SearchResult>[].obs;

  final filteredResults = <SearchResult>[].obs;

  var currentInput = ''.obs;

  //map controller
  MapsController mapsController = Get.find<MapsController>();

  @override
  void onInit() {
    super.onInit();

    // Populate results with some dummy data
    searchResults.addAll([
      SearchResult(
          name: 'Pom Bensin Hayam Wuruk',
          visibility: 'Subtitle 1',
          lat: -6.1751,
          lng: 106.8650),
      SearchResult(
          name: 'Resto ayam kencana',
          visibility: 'Subtitle 2',
          lat: -6.1751,
          lng: 106.8650),
      SearchResult(
          name: 'POM Bensin sanur',
          visibility: 'Subtitle 3',
          lat: -6.1751,
          lng: 106.8650),
      SearchResult(
          name: 'POM Bensin Kuta',
          visibility: 'Subtitle 4',
          lat: -6.1751,
          lng: 106.8650),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectLocation(SearchResult result) {
    print('Selected Location: ${result.name}');

    //create new array of search result with a new object before overwriting the searchResults
    final newSearchResults = [result, ...searchResults];

    //update the searchResults
    searchResults.value = newSearchResults;

    Get.back();
    Future.delayed(Duration(milliseconds: 500), () {
      mapsController.moveCamera(result.lat, result.lng);
    });
  }

  void removeRecentSearchSelected(SearchResult result) {
    final newSearchResults = searchResults.where((element) => element != result).toList();
    searchResults.value = newSearchResults;
  }

  Future<void> search(String input) async {
    String apiKey = Constants.MAP_API_KEY;
    currentInput.value = input;

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
            visibility: vicinity,
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
