part of 'data_source.dart';

class FeedbackDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListPaginationApiResponse<FeedbackDto>> getFeedbackList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/feedbacks.json');
      final data = await json.decode(response);

      return ListPaginationApiResponse.fromJson(
        data,
        (json) => json
            .map(
              (e) => FeedbackDto.fromJson(e),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}