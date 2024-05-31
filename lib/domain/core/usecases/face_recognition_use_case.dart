import 'dart:io';

import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class FaceRecognitionUseCase implements IFaceRecognitionUseCase {
  const FaceRecognitionUseCase({required this.dataSource});

  final UserDataSource dataSource;

  @override
  Future<UserModel> verifyDriverFace(File image) async {
    try {
      final response = await dataSource.verifyDriverFace(image);
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
      errorHandler(e);
      rethrow;
    }
  }
}
