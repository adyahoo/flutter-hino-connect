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

  Future<void> logout() async {
    try {
      await services.logout();

      inject<StorageService>().clearToken();
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDto> verifyDriverFace(File image) async {
    try {
      final res = await services.verifyDriverFace(image);

      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserDto body) async {
    try {
      await services.updateProfile(body);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfilePicture(File profilePic) async {
    try {
      await services.updateProfilePicture(profilePic);
    } catch (e) {
      rethrow;
    }
  }
}
