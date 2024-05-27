part of 'data_source.dart';

class UserDataSource {
  const UserDataSource({required this.services});

  final UserServices services;

  Future<void> login(LoginBodyDto body) async {
    try {
      final res = await services.login(body);

      inject<StorageService>().setToken(res.data.token);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDto> getUser() async {
    try {
      final res = await services.getProfile();

      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
