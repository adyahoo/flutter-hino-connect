import 'package:get/get.dart';

class Result {
  final String title;
  final String subtitle;

  Result({required this.title, required this.subtitle});
}

class SearchPageController extends GetxController {
  // Define results as an observable list
  final results = <Result>[].obs;

  final filteredResults = <Result>[].obs;

  var currentInput = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Populate results with some dummy data
    results.addAll([
      Result(title: 'Pom Bensin Hayam Wuruk', subtitle: 'Subtitle 1'),
      Result(title: 'Resto ayam kencana', subtitle: 'Subtitle 2'),
      Result(title: 'POM Bensin sanur', subtitle: 'Subtitle 3'),
      Result(title: 'POM Bensin Kuta', subtitle: 'Subtitle 4'),
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

  void selectLocation(Result result) {
    // Implement your logic here
  }

//   void search(String query) {
//   // Implement your search logic here
//   // For example, filter your data based on the query
//   var filteredResults = results.where((result) {
//     return result.title.toLowerCase().contains(query.toLowerCase());
//   }).toList();

//   // Update the results list
//   results.value = filteredResults;
// }

  void search(String query) {
    // Filter your data based on the query
    var newFilteredResults = results.where((result) {
      return result.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    print('\nFiltered Results: $newFilteredResults\n');

    // Update the filteredResults list
    filteredResults.assignAll(newFilteredResults);
    currentInput.value = query;

    print('\nCurrent Input: $currentInput\n');
  }
}