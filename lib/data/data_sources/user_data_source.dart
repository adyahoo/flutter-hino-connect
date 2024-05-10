part of 'data_source.dart';

class UserDataSource {
  Future<SingleApiResponse<UserDto>> getUser() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await DefaultAssetBundle.of(rootScaffoldMessengerKey.currentContext!).loadString('assets/response_helpers/users.json');
      final data = await json.decode(response);

      return SingleApiResponse.fromJson(data, (json) => UserDto.fromJson(json));
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }
}