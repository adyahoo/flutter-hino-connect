import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hino_driver_app/data/dtos/single_base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/user_dto.dart';
import 'package:hino_driver_app/infrastructure/client/client.dart';

class UserServices {
  const UserServices(this.client);

  final Dio client;

  Future<SingleApiResponse<LoginDto>> login(LoginBodyDto body) async {
    return clientExecutor(execute: () async {
      final res = await client.post("user/login", data: body.toJson());

      return SingleApiResponse.fromJson(res.data, (json) => LoginDto.fromJson(json));
    });
  }

  Future<SingleApiResponse<UserDto>> getProfile() async {
    return clientExecutor(execute: () async {
      final res = await client.get("user/profile");

      return SingleApiResponse.fromJson(res.data, (json) => UserDto.fromJson(json));
    });
  }

  Future<SingleApiResponse<UserDto>> updateProfile(UserDto body) async {
    return clientExecutor(execute: () async {
      final res = await client.patch("user/profile", data: body.toJson());

      return SingleApiResponse.fromJson(res.data, (json) => UserDto.fromJson(json));
    });
  }
  
  //update photo profile which accept multiform part data
    Future<SingleApiResponse<UserDto>> updateProfilePicture(File profilePic) async {
    return clientExecutor(execute: () async {
      final formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(profilePic.path),
      });

      final res = await client.post("user/profile/picture", data: formData);

      return SingleApiResponse<UserDto>.fromJson(res.data, (json) => UserDto.fromJson(json));
    });
  }

}
