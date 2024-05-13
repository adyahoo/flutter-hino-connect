part of 'data_source.dart';

class EventDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListApiResponse<EventDto>> getEventList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/events.json');
      final data = await json.decode(response);

      return ListApiResponse.fromJson(
        data,
            (json) => json
            .map(
              (e) => EventDto.fromJson(e),
        )
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
