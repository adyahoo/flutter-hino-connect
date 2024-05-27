import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/single_base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';

abstract class IUserUseCase {
  Future<void> login(LoginBody body);

  Future<UserModel> getUser();
}
