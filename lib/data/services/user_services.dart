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
}
