import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/data/dtos/base_response_dto.dart';
import 'package:hino_driver_app/data/dtos/single_base_response_dto.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';

class UserUseCase {
  const UserUseCase({required this.dataSource});

  final UserDataSource dataSource;

  Future<SingleApiResponse<UserModel>> getUser() async {
    try {
      final response = await dataSource.getUser();
      final data = UserModel(
        id: response.data.id,
        name: response.data.name,
        email: response.data.email,
        role: response.data.role,
        profilePic: response.data.profilePic,
        status: response.data.status,
        score: response.data.score,
        phoneCode: response.data.phoneCode,
        phoneNumber: response.data.phoneNumber,
        createdAt: response.data.createdAt,
        updatedAt: response.data.updatedAt,
      );

      return SingleApiResponse(
        data: data,
        message: response.message,
        success: response.success,
      );
    } catch (e) {
      //call error handler dialog
      rethrow;
    }
  }
}
