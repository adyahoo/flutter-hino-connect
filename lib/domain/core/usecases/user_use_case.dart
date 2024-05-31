import 'dart:io';

import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/single_base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/user_dto.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_user_use_case.dart';

class UserUseCase implements IUserUseCase {
  const UserUseCase({required this.dataSource});

  final UserDataSource dataSource;

  Future<UserModel> getUser() async {
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
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }

  @override
  Future<void> login(LoginBody body) async {
    try {
      final bodyData = LoginBodyDto(email: body.email, password: body.password);
      await dataSource.login(bodyData);
    } catch (e) {
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
