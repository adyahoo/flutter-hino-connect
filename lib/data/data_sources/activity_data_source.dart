part of 'data_source.dart';

class ActivityDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListApiResponse<ActivityDto>> getActivityList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/activities.json');
      final data = await json.decode(response);

      return ListApiResponse.fromJson(
        data,
        (json) => json
            .map(
              (e) => ActivityDto.fromJson(e),
            )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
