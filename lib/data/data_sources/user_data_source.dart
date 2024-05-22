part of 'data_source.dart';

class UserDataSource {
  Future<SingleApiResponse<UserDto>> getUser() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final res = await inject<StorageService>().getJsonData(StorageService.USERS_JSON);

      return SingleApiResponse.fromJson(res!, (json) => UserDto.fromJson(json));
    } catch (e) {
      rethrow;
    }
  }
}
