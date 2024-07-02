import 'dart:io';

import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/user_dto.dart';
import 'package:hino_driver_app/data/locals/storage_service.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/di.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class UserUseCase implements IUserUseCase {
  const UserUseCase({required this.dataSource});

  final UserDataSource dataSource;

  Future<UserModel> getUser() async {
    print('masuk ke user usecase getuser');
    try {
      final response = await dataSource.getUser();
      final data = UserModel(
        id: response.id,
        name: response.name,
        email: response.email,
        profilePic: response.profilePic,
        phoneCode: response.phoneCode,
        phone: response.phone,
      );

      return data;
    } on ApiException catch (e) {
      print('error di user usecase getuser: $e');
      print(e.exception);
      print(e.response);
      errorHandler(e);
      rethrow;
    }
  }

  @override
  Future<void> login(LoginBody body) async {
    try {
      final bodyData = LoginBodyDto(email: body.email, password: body.password);
      await dataSource.login(bodyData);
    } on ApiException catch (e) {
      errorHandler(e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dataSource.logout();
      inject<StorageService>().setScheduleNotifFired(status: false);
    } on ApiException catch (e) {
      errorHandler(e);
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserModel body) async {
    try {
      final bodyData = UserDto(
        id: body.id,
        name: body.name,
        email: body.email,
        profilePic: body.profilePic,
        phoneCode: body.phoneCode,
        phone: body.phone,
      );
      await dataSource.updateUser(bodyData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfilePicture(File profilePic) async {
    try {
      await dataSource.updateProfilePicture(profilePic);
    } catch (e) {
      rethrow;
    }
  }
}
