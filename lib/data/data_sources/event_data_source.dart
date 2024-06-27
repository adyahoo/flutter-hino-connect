part of 'data_source.dart';

class EventDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListPaginationApiResponse<EventDto>> getEventList() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final data = await inject<StorageService>().getJsonData(StorageService.EVENTS_JSON);

      return ListPaginationApiResponse.fromJson(
        data!,
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
  Future<void> addEvent(EventDto newData) async {
    try {
      final res = await getEventList();
      res.data.insert(0, newData);

      inject<StorageService>().setJsonData(StorageService.EVENTS_JSON, res.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEvent(EventDto newData) async {
    try {
      final res = await getEventList();
      final editedIndex = res.data.indexWhere((element) => element.id == newData.id);

      res.data[editedIndex] = newData;

      inject<StorageService>().setJsonData(StorageService.EVENTS_JSON, res.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEvent(int id) async {
    try{
      final res = await getEventList();
      res.data.removeWhere((element) => element.id == id);

      inject<StorageService>().setJsonData(StorageService.EVENTS_JSON, res.toJson());
    }catch(e){
      rethrow;
    }
  }
}
