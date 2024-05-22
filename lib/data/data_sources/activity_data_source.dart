part of 'data_source.dart';

class ActivityDataSource {
  // you should use real http client here later (ex: dio)

  Future<ListPaginationApiResponse<ActivityDto>> getActivityList() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final data = await inject<StorageService>().getJsonData(StorageService.ACTIVITIES_JSON);

      return ListPaginationApiResponse.fromJson(
        data!,
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

  Future<void> addActivity(ActivityDto newData) async {
    try {
      final res = await getActivityList();
      res.data.insert(0, newData);

      inject<StorageService>().setJsonData(StorageService.ACTIVITIES_JSON, res.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateActivity(ActivityDto newData) async {
    try {
      final res = await getActivityList();
      final editedIndex = res.data.indexWhere((element) => element.id == newData.id);

      res.data[editedIndex] = newData;

      inject<StorageService>().setJsonData(StorageService.ACTIVITIES_JSON, res.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteActivity(int id) async {
    try{
      final res = await getActivityList();
      res.data.removeWhere((element) => element.id == id);

      inject<StorageService>().setJsonData(StorageService.ACTIVITIES_JSON, res.toJson());
    }catch(e){
      rethrow;
    }
  }
}
